import UIKit
import SideMenu
import SQLite

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WindowStateController, RootViewManager, DeepLinkManager {

    var window: UIWindow?

    var windowStateManager: (WindowStateManager & WindowStateObserver)?
    
    var router: Router?
    
    var rootView: View?
    
    var pendingDeviceUrl: (String, URL)?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        
        windowStateManager = ApplicationDelegateWindowStateManager(delegate: self)
        
        let deepLinkManager: DeepLinkManager = self
        
        do {
            
//            let repositoryFactory: RepositoryFactory = try SQLiteRepositoryFactory() //no dbPath creates an in-memory only database
            
            let repositoryFactory: RepositoryFactory = try SQLiteRepositoryFactory(dbPath: documentsPath)
            
            let serverResolveer: ServerResolver = ProfileServerResolver()
            
            let cacheFactory: CacheFactory = UserDefaultsCacheFactory()
            
            let apiFactory: ApiFactory = AlamofireApiFactory(serverResolver: serverResolveer, tokenRepository: repositoryFactory.getLoginTokenRepository(), returnToLogin)
            
            let loginService: LoginService = ProfileLoginService(apiFactory: apiFactory, loginRepository: repositoryFactory.getProfileLoginRepository(), cacheFactory: cacheFactory)
            
            let deviceService = ProfileDeviceService(apiFactory: apiFactory, loginRepository: repositoryFactory.getProfileLoginRepository(), cacheFactory: cacheFactory)
            
            let nearbyProfileScanner = MulticastNearbyProfileScanner(groupAddress: "224.0.0.147", port: 9889)
            
            let nearbyProfileService = ScanningNearbyProfileService(scanner: nearbyProfileScanner)
            
            let profilePresenterFactory = ProfilePresenterFactory(windowStateManager: windowStateManager!, nearbyProfileService: nearbyProfileService, loginService: loginService, deviceService: deviceService, deepLinkManager: deepLinkManager)
            
            let profileViewFactory = ProfileViewFactory()
            
            router = ProfileRouter(rootViewManager: self, presenterFactory: profilePresenterFactory, viewFactory: profileViewFactory)
            
            let semaphore = DispatchSemaphore(value: 0)
            var existingLogin: ProfileLogin?
            loginService.getActiveLogin { result, error in
                existingLogin = result
                semaphore.signal()
            }
            
            semaphore.wait()
            
            if existingLogin != nil {
                router!.routeToMain()
            } else {
                router!.routeToGetStarted()
            }

            return true
            
        } catch {
            return false
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//        print("applicationWillResignActive")
        windowStateManager?.willResignActive()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//        print("applicationDidEnterBackground")
        windowStateManager?.didEnterBackground()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//        print("applicationWillEnterForeground")
        windowStateManager?.willEnterForeground()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//        print("applicationDidBecomeActive")
        windowStateManager?.didBecomeActive()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//        print("applicationWillTerminate")
    }
    
    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        
        // Determine who sent the URL.
        let sendingAppID = options[.sourceApplication]
        print("source application = \(sendingAppID ?? "Unknown")")
        
        // Process the URL.
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
            let path = components.path,
            let host = components.host,
            let params = components.queryItems else {
                print("Invalid URL or path missing")
                return false
        }
        
        if (host.lowercased() == "device") {
        
            if let id = params.first(where: { $0.name == "id" })?.value {
                print("id = \(id)")
                pendingDeviceUrl = (id, url)
                router?.routeToMain()
                return true
            } else {
                print("id missing")
                return false
            }
            
        } else {
            print("invalid host")
            return false
        }
        
    }
    
    func getPendingDeviceUrl() -> (String, URL)? {
        if let deviceUrl = pendingDeviceUrl {
            let deviceUrl = (deviceUrl.0, deviceUrl.1)
            pendingDeviceUrl = nil
            return deviceUrl
        } else {
            return nil
        }
    }
    
    var orientationLock = UIInterfaceOrientationMask.all
    
    func lockOrientationPortrait() {
        orientationLock = UIInterfaceOrientationMask.portrait
    }
    
    func lockOrientationLandscape() {
        orientationLock = UIInterfaceOrientationMask.landscapeLeft
    }
    
    func lockOrientationAll() {
        orientationLock = UIInterfaceOrientationMask.all
    }
    
    func rotateToPortrait() {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    func rotateToLandscape() {
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    func setRoot(view: View, animated: Bool, wrapWithNavController: Bool) {
        
        rootView = view
        
        guard animated, let window = self.window else {
            let rootView = wrapWithNavController ? UINavigationController(rootViewController: view.viewController()) : view.viewController()
            self.window?.rootViewController = rootView
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = view.viewController()
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
        
    }
    
    func getRootView() -> View {
        return rootView!
    }
    
    private func returnToLogin(login: ProfileLogin) {
        DispatchQueue.main.async {
            let mapper = DefaultProfileLoginMapper()
            let item = mapper.from(profileId: login.profileId, servers: login.loginTokens.map { $0.key })
            self.router?.routeToRelogin(item: item, user: login.username)
        }
    }

}


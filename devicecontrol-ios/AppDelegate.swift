import UIKit
import SideMenu
import SQLite

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WindowStateController, RootViewManager {

    var window: UIWindow?

    var windowStateManager: (WindowStateManager & WindowStateObserver)?
    
    var rootView: View?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        
        windowStateManager = ApplicationDelegateWindowStateManager(delegate: self)
        
        do {
            
//            let repositoryFactory: RepositoryFactory = try SQLiteRepositoryFactory(dbPath: documentsPath)
            
            let repositoryFactory: RepositoryFactory = try SQLiteRepositoryFactory()
            
            let serverResolveer: ServerResolver = ProfileServerResolver()
            
            let cacheFactory: CacheFactory = UserDefaultsCacheFactory()
            
            let apiFactory: ApiFactory = AlamofireApiFactory(serverResolver: serverResolveer, tokenRepository: repositoryFactory.getLoginTokenRepository())
            
            let loginService = ProfileLoginService(apiFactory: apiFactory, loginRepository: repositoryFactory.getProfileLoginRepository(), cacheFactory: cacheFactory)
            
            
//
//            let cacheFactory = UserDefaultsCacheFactory()
//
//
    //        let semaphore = DispatchSemaphore(value: 0)
    //
    //        var hasSavedLogin
    //
    //        loginService.getAllLogins { result, error in7
    //            semaphore.signal()
    //        }
    //
    //        semaphore.wait()
            
//            let deviceService = ProfileDeviceService(profileApi: profileApi, cacheFactory: cacheFactory)
            
//            let deviceViewMapper = ProfileDeviceMapper()
            
//            let devicesPresenter = ProfileDevicesPresenter(deviceService: deviceService, deviceMapper: deviceViewMapper)
            
//            let devicesViewController = DevicesViewController(presenter: devicesPresenter)
            
//            devicesPresenter.setView(view: devicesViewController)
            
//            let homeViewController = HomeViewController()
            
//            let settingsViewController = SettingsViewController()
        
//            let loginService = ProfileLoginService(profileLogin: profileLogin)
        
//        let initialViewController = MainViewController(devicesViewController: devicesViewController, homeViewController: homeViewController, settingsViewController: settingsViewController)
            
            let nearbyProfileScanner = MulticastNearbyProfileScanner(groupAddress: "224.0.0.147", port: 9889)
            
            let nearbyProfileService = ScanningNearbyProfileService(scanner: nearbyProfileScanner)
            
            let profilePresenterFactory = ProfilePresenterFactory(windowStateManager: windowStateManager!, nearbyProfileService: nearbyProfileService, loginService: loginService)
            
            let profileViewFactory = ProfileViewFactory()
            
            let profileRouter = ProfileRouter(rootViewManager: self, presenterFactory: profilePresenterFactory, viewFactory: profileViewFactory)
            
            profileRouter.routeToGetStarted()

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
    
    func setRoot(view: View, animated: Bool) {
        
        rootView = view
        
        guard animated, let window = self.window else {
            self.window?.rootViewController = UINavigationController(rootViewController: view.viewController())
            self.window?.makeKeyAndVisible()
            return
        }

        window.rootViewController = UINavigationController(rootViewController: view.viewController())
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

}


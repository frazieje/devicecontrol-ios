import SideMenu
import UIKit

class ProfileRouter : Router {
    
    private let rootViewManager: RootViewManager
    private let presenterFactory: PresenterFactory
    private let viewFactory: ViewFactory
    
    private var sideMenu: SideMenuNavigationController?
    
    init(rootViewManager: RootViewManager, presenterFactory: PresenterFactory, viewFactory: ViewFactory) {
        self.rootViewManager = rootViewManager
        self.presenterFactory = presenterFactory
        self.viewFactory = viewFactory
    }
    
    func routeToNearbyProfileLogin(from: View) {
        
        let presenter = presenterFactory.nearbyProfileLogin(router: self)
        
        let view = viewFactory.nearbyProfileLogin(presenter: presenter)
        
        from.viewController().show(view.viewController(), sender: from)
    }
    
    func routeToEditProfileLogin(from: View, item: ProfileServerItem?) {
        
        let presenter = presenterFactory.editProfileLogin(router: self, item, nil)
        
        let view = viewFactory.editProfileLogin(presenter: presenter)
        
        from.viewController().show(view.viewController(), sender: from)
    }
    
    func routeToLoginAction(from: View, item: ProfileLoginViewModel) {
        
        let presenter = presenterFactory.loginAction(router: self, item: item)
        
        let view = viewFactory.loginAction(presenter: presenter)
        
        from.viewController().show(view.viewController(), sender: from)
    }
    
    func routeToMain() {
        
        let mainPresenter = presenterFactory.main(router: self)
        
        let mainView = viewFactory.main(presenter: mainPresenter)
        
        let homePresenter = presenterFactory.home(router: self)
        
        let homeView = viewFactory.home(presenter: homePresenter)
        
        let devicesPresenter = presenterFactory.devices(router: self)
        
        let devicesView = viewFactory.devices(presenter: devicesPresenter)
        
        let settingsPresenter = presenterFactory.settings(router: self)
        
        let settingsView = viewFactory.settings(presenter: settingsPresenter)
        
        mainView.setChildViews(homeView, devicesView, settingsView)
        
        let menuPresenter = presenterFactory.menu(router: self)
        
        let menuView = viewFactory.menu(presenter: menuPresenter)
        
        sideMenu = SideMenuNavigationController(rootViewController: menuView.viewController())
        
        SideMenuManager.default.rightMenuNavigationController = sideMenu

        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: mainView.viewController().view)
        
        sideMenu?.statusBarEndAlpha = 0
        
        let style: SideMenuPresentationStyle = .menuSlideIn
        
        style.presentingEndAlpha = CGFloat(0.5)
        
        sideMenu?.presentationStyle = style
        sideMenu?.blurEffectStyle = .extraLight
        
        rootViewManager.setRoot(view: mainView, animated: true, wrapWithNavController: false)
        
    }
    
    func routeToGetStarted() {
        
        let presenter = presenterFactory.getStartedPresenter(router: self)
        
        let view = viewFactory.getStarted(presenter: presenter)
        
        rootViewManager.setRoot(view: view, animated: false, wrapWithNavController: true)
        
    }
    
    func routeToViewController(_ vc: UIViewController, from: View) {
        
        from.viewController().show(vc, sender: from)
        
    }
    
    func routeToRelogin(item: ProfileServerItem, user: String) {
        
        let presenter = presenterFactory.editProfileLogin(router: self, item, user)
        
        let view = viewFactory.editProfileLogin(presenter: presenter)
        
        rootViewManager.setRoot(view: view, animated: true, wrapWithNavController: true)
        
    }
    
    
    func showMenu() {
        if let menu = sideMenu {
            rootViewManager.getRootView().viewController().present(menu, animated: true, completion: nil)
        }
    }
    
    func hideMenu() {
        if let menu = sideMenu {
            menu.dismiss(animated: true, completion: nil)
        }
    }
    
}


import Foundation

class ProfileMainPresenter : MainPresenter {
    
    private var view: MainView?
    
    private let router: Router
    
    private let windowStateManager: WindowStateManager
    
    private let loginService: LoginService
    
    init(router: Router, windowStateManager: WindowStateManager, loginService: LoginService) {
        self.router = router
        self.windowStateManager = windowStateManager
        self.loginService = loginService
    }

    func onViewLoad() {
        loginService.getActiveLogin { [weak self] login, error in
            guard let self = self else { return }
            if error == nil {
                self.loadChildViews(loginName: login!.name ?? "H")
            } else {
                print("\(error!.message)")
            }
        }
    }
    
    private func loadChildViews(loginName: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.loadChildViews(profileName: loginName, selectedIndex: 1)
        }
    }
    
    func onViewAppear() {
        windowStateManager.lockOrientationPortrait()
        windowStateManager.rotateToPortrait()
    }
    
    func onViewDisappear() {
        windowStateManager.lockOrientationAll()
    }
    
    func onProfileButtonClicked() {
        router.showMenu()
    }
    
    func setView(view: MainView) {
        self.view = view
    }
    
}

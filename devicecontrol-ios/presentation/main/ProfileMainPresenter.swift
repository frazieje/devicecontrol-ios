import Foundation

class ProfileMainPresenter : MainPresenter {
    
    private var view: MainView?
    
    private let router: Router
    
    private let loginService: LoginService
    
    init(router: Router, loginService: LoginService) {
        self.router = router
        self.loginService = loginService
    }

    func onViewLoad() {
        loginService.getActiveLogin { [weak self] login, error in
            guard let self = self else { return }
            if error == nil {
                self.showProfileButton(loginName: login!.name ?? "H")
            } else {
                print("\(error!.message)")
            }
        }
    }
    
    private func showProfileButton(loginName: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.showProfileButton(profileName: loginName)
        }
    }
    
    func onViewAppear() {
        
    }
    
    func onViewDisappear() {
        
    }
    
    func onProfileButtonClicked() {
        router.showMenu()
    }
    
    func setView(view: MainView) {
        self.view = view
    }
    
}

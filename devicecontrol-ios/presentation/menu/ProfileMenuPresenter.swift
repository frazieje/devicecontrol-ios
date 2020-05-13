class ProfileMenuPresenter : MenuPresenter {

    let loginService: LoginService
    
    var menuView: MenuView? = nil
    
    init(loginService: LoginService) {
        self.loginService = loginService
    }
    
    func onViewLoad() {
        
    }
    
    func onViewAppear() {
        
    }
    
    func onViewDisappear() {
        
    }
    
    func setView(view: MenuView) {
        menuView = view
    }
    
}

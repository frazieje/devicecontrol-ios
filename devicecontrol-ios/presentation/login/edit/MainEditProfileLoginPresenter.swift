class MainEditProfileLoginPresenter : EditProfileLoginPresenter {

    private let router: ProfileLoginRouter
    
    private var view: EditProfileLoginView?
    
    init(router: ProfileLoginRouter) {
        self.router = router
    }
    
    func onViewAppear() {
        
    }
    
    func onViewDisappear() {
        
    }
    
    func setView(view: EditProfileLoginView) {
        self.view = view
    }
    
    
}

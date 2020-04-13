class MainProfileLoginRouter : ProfileLoginRouter {

    private let presenterFactory: ProfileLoginPresenterFactory
    private let viewFactory: ProfileLoginViewFactory
    
    init(presenterFactory: ProfileLoginPresenterFactory, viewFactory: ProfileLoginViewFactory) {
        self.presenterFactory = presenterFactory
        self.viewFactory = viewFactory
    }
    
    func routeToAddProfileLogin(from: View) {
        
        let presenter = presenterFactory.addProfileLogin(router: self)
        
        let view = viewFactory.addProfileLogin(presenter: presenter)
        
        from.viewController().show(view.viewController(), sender: from)
    }
    
    func routeToEditProfileLogin(from: View, _ item: ProfileServerItem?) {
        
        let presenter = presenterFactory.editProfileLogin(router: self)
        
        let view = viewFactory.editProfileLogin(presenter: presenter, item)
        
        from.viewController().show(view.viewController(), sender: from)
    }
    
}


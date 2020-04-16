class MainProfileLoginRouter : ProfileLoginRouter {

    private let presenterFactory: ProfileLoginPresenterFactory
    private let viewFactory: ProfileLoginViewFactory
    
    init(presenterFactory: ProfileLoginPresenterFactory, viewFactory: ProfileLoginViewFactory) {
        self.presenterFactory = presenterFactory
        self.viewFactory = viewFactory
    }
    
    func routeToAddProfileLogin(from: View) {
        
        let presenter = presenterFactory.nearbyProfileLogin(router: self)
        
        let view = viewFactory.nearbyProfileLogin(presenter: presenter)
        
        from.viewController().show(view.viewController(), sender: from)
    }
    
    func routeToEditProfileLogin(from: View, _ item: ProfileServerItem?) {
        
        let presenter = presenterFactory.editProfileLogin(router: self)
        
        let view = viewFactory.editProfileLogin(presenter: presenter, item)
        
        from.viewController().show(view.viewController(), sender: from)
    }
    
}


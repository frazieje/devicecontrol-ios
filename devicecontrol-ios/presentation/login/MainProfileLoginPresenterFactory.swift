class MainProfileLoginPresenterFactory : ProfileLoginPresenterFactory {

    private let windowStateManager: WindowStateManager
    
    private let nearbyProfileService: NearbyProfileService
    
    private let loginService: LoginService
    
    init(windowStateManager: WindowStateManager, nearbyProfileService: NearbyProfileService, loginService: LoginService) {
        self.windowStateManager = windowStateManager
        self.nearbyProfileService = nearbyProfileService
        self.loginService = loginService
    }
    
    func getStartedPresenter(router: ProfileLoginRouter) -> GetStartedPresenter {
        return MainGetStartedPresenter(windowStateManager: windowStateManager, router: router)
    }
    
    func nearbyProfileLogin(router: ProfileLoginRouter) -> NearbyProfileLoginPresenter {
        
        let serverItemMapper: ProfileLoginMapper = DefaultProfileLoginMapper()
        
        return MainNearbyProfileLoginPresenter(windowStateManager: windowStateManager, nearbyProfileService: nearbyProfileService, mapper: serverItemMapper, router: router)
        
    }
    
    func editProfileLogin(router: ProfileLoginRouter, _ item: ProfileServerItem?) -> EditProfileLoginPresenter {
        
        let serverItemMapper: ProfileLoginMapper = DefaultProfileLoginMapper()
        
        let serverItemValidator: ProfileLoginViewModelValidator = MainProfileLoginViewModelValidator()
        
        return MainEditProfileLoginPresenter(mapper: serverItemMapper, router: router, validator: serverItemValidator, item)
    }
    
    func loginAction(router: ProfileLoginRouter, item: ProfileLoginViewModel) -> LoginActionPresenter {
        
        let loginItemMapper: ProfileLoginMapper = DefaultProfileLoginMapper()
        
        return MainLoginActionPresenter(loginService: loginService, router: router, mapper: loginItemMapper, item: item)
    }
    
    
}

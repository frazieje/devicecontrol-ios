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
        
        let serverItemMapper: ProfileServerMapper = DefaultProfileServerMapper()
        
        return MainNearbyProfileLoginPresenter(windowStateManager: windowStateManager, nearbyProfileService: nearbyProfileService, mapper: serverItemMapper, router: router)
    }
    
    func editProfileLogin(router: ProfileLoginRouter, _ item: ProfileServerItem?) -> EditProfileLoginPresenter {
        
        let serverItemMapper: ProfileServerMapper = DefaultProfileServerMapper()
        
        let serverItemValidator: ProfileLoginViewModelValidator = MainProfileLoginViewModelValidator()
        
        return MainEditProfileLoginPresenter(loginService: loginService, mapper: serverItemMapper, router: router, validator: serverItemValidator, item)
    }
    
    
}

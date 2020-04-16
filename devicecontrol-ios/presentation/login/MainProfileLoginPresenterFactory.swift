class MainProfileLoginPresenterFactory : ProfileLoginPresenterFactory {
    
    private let windowStateManager: WindowStateManager
    
    private let nearbyProfileService: NearbyProfileService
    
    init(windowStateManager: WindowStateManager, nearbyProfileService: NearbyProfileService) {
        self.windowStateManager = windowStateManager
        self.nearbyProfileService = nearbyProfileService
    }
    
    func getStartedPresenter(router: ProfileLoginRouter) -> GetStartedPresenter {
        return MainGetStartedPresenter(windowStateManager: windowStateManager, router: router)
    }
    
    func nearbyProfileLogin(router: ProfileLoginRouter) -> NearbyProfileLoginPresenter {
        
        let serverItemMapper: ServerItemMapper = ProfileServerItemMapper()
        
        return MainNearbyProfileLoginPresenter(windowStateManager: windowStateManager, nearbyProfileService: nearbyProfileService, mapper: serverItemMapper, router: router)
    }
    
    func editProfileLogin(router: ProfileLoginRouter) -> EditProfileLoginPresenter {
        return MainEditProfileLoginPresenter(router: router)
    }
    
    
}

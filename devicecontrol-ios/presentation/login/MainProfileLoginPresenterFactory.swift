class MainProfileLoginPresenterFactory : ProfileLoginPresenterFactory {
    
    private let windowStateManager: WindowStateManager
    
    private let nearbyProfileService: NearbyProfileService
    
    init(windowStateManager: WindowStateManager, nearbyProfileService: NearbyProfileService) {
        self.windowStateManager = windowStateManager
        self.nearbyProfileService = nearbyProfileService
    }
    
    func addProfileLogin(router: ProfileLoginRouter) -> AddProfileLoginPresenter {
        
        let serverItemMapper: ServerItemMapper = ProfileServerItemMapper()
        
        return MainAddProfileLoginPresenter(windowStateManager: windowStateManager, nearbyProfileService: nearbyProfileService, mapper: serverItemMapper, router: router)
    }
    
    func editProfileLogin(router: ProfileLoginRouter) -> EditProfileLoginPresenter {
        return MainEditProfileLoginPresenter(router: router)
    }
    
    
}

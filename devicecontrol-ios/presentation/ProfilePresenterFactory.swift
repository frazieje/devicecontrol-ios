class ProfilePresenterFactory : PresenterFactory {

    private let windowStateManager: WindowStateManager
    
    private let nearbyProfileService: NearbyProfileService
    
    private let loginService: LoginService
    
    private let deviceService: DeviceService
    
    private let deepLinkManager: DeepLinkManager
    
    init(windowStateManager: WindowStateManager, nearbyProfileService: NearbyProfileService, loginService: LoginService, deviceService: DeviceService, deepLinkManager: DeepLinkManager) {
        self.windowStateManager = windowStateManager
        self.nearbyProfileService = nearbyProfileService
        self.loginService = loginService
        self.deviceService = deviceService
        self.deepLinkManager = deepLinkManager
    }
    
    func getStartedPresenter(router: Router) -> GetStartedPresenter {
        return MainGetStartedPresenter(windowStateManager: windowStateManager, router: router)
    }
    
    func nearbyProfileLogin(router: Router) -> NearbyProfileLoginPresenter {
        
        let serverItemMapper: ProfileLoginMapper = DefaultProfileLoginMapper()
        
        return MainNearbyProfileLoginPresenter(windowStateManager: windowStateManager, nearbyProfileService: nearbyProfileService, mapper: serverItemMapper, router: router)
        
    }
    
    func editProfileLogin(router: Router, _ item: ProfileServerItem?, _ user: String?) -> EditProfileLoginPresenter {
        
        let serverItemMapper: ProfileLoginMapper = DefaultProfileLoginMapper()
        
        let serverItemValidator: ProfileLoginViewModelValidator = MainProfileLoginViewModelValidator()
        
        return MainEditProfileLoginPresenter(mapper: serverItemMapper, router: router, validator: serverItemValidator, item, user)
    }
    
    func loginAction(router: Router, item: ProfileLoginViewModel) -> LoginActionPresenter {
        
        let loginItemMapper: ProfileLoginMapper = DefaultProfileLoginMapper()
        
        return MainLoginActionPresenter(loginService: loginService, windowStateManager: windowStateManager, router: router, mapper: loginItemMapper, item: item)
    }
    
    func main(router: Router) -> MainPresenter {
        
        return ProfileMainPresenter(router: router, windowStateManager: windowStateManager, loginService: loginService)
        
    }
    
    func menu(router: Router) -> MenuPresenter {
        return ProfileMenuPresenter(loginService: loginService)
    }
    
    func home(router: Router) -> HomePresenter {
        return ProfileHomePresenter()
    }
    
    func devices(router: Router) -> DevicesPresenter {
        
        let deviceMapper = ProfileDeviceMapper()
        
        let deviceViewFactory = ProfileDeviceViewFactory(router: router, deviceService: deviceService)
        
        return ProfileDevicesPresenter(router: router, deviceService: deviceService, deviceMapper: deviceMapper, viewFactory: deviceViewFactory, deepLinkManager: deepLinkManager)
    }
    
    func settings(router: Router) -> SettingsPresenter {
        
        return MainSettingsPresenter()
        
    }
    
    
}

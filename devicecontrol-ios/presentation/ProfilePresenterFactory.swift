class ProfilePresenterFactory : PresenterFactory {

    private let windowStateManager: WindowStateManager
    
    private let nearbyProfileService: NearbyProfileService
    
    private let loginService: LoginService
    
    private let deviceService: DeviceService
    
    init(windowStateManager: WindowStateManager, nearbyProfileService: NearbyProfileService, loginService: LoginService, deviceService: DeviceService) {
        self.windowStateManager = windowStateManager
        self.nearbyProfileService = nearbyProfileService
        self.loginService = loginService
        self.deviceService = deviceService
    }
    
    func getStartedPresenter(router: Router) -> GetStartedPresenter {
        return MainGetStartedPresenter(windowStateManager: windowStateManager, router: router)
    }
    
    func nearbyProfileLogin(router: Router) -> NearbyProfileLoginPresenter {
        
        let serverItemMapper: ProfileLoginMapper = DefaultProfileLoginMapper()
        
        return MainNearbyProfileLoginPresenter(windowStateManager: windowStateManager, nearbyProfileService: nearbyProfileService, mapper: serverItemMapper, router: router)
        
    }
    
    func editProfileLogin(router: Router, _ item: ProfileServerItem?) -> EditProfileLoginPresenter {
        
        let serverItemMapper: ProfileLoginMapper = DefaultProfileLoginMapper()
        
        let serverItemValidator: ProfileLoginViewModelValidator = MainProfileLoginViewModelValidator()
        
        return MainEditProfileLoginPresenter(mapper: serverItemMapper, router: router, validator: serverItemValidator, item)
    }
    
    func loginAction(router: Router, item: ProfileLoginViewModel) -> LoginActionPresenter {
        
        let loginItemMapper: ProfileLoginMapper = DefaultProfileLoginMapper()
        
        return MainLoginActionPresenter(loginService: loginService, windowStateManager: windowStateManager, router: router, mapper: loginItemMapper, item: item)
    }
    
    func main(router: Router) -> MainPresenter {
        
        return ProfileMainPresenter(router: router, loginService: loginService)
        
    }
    
    func menu(router: Router) -> MenuPresenter {
        return ProfileMenuPresenter(loginService: loginService)
    }
    
    func home(router: Router) -> HomePresenter {
        return ProfileHomePresenter()
    }
    
    func devices(router: Router) -> DevicesPresenter {
        
        let deviceMapper = ProfileDeviceMapper()
        
        return ProfileDevicesPresenter(deviceService: deviceService, deviceMapper: deviceMapper)
    }
    
    func settings(router: Router) -> SettingsPresenter {
        
        return MainSettingsPresenter()
        
    }
    
    
}

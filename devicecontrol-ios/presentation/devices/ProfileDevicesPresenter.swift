class ProfileDevicesPresenter : DevicesPresenter {

    let deviceService: DeviceService
    
    var devicesView: DevicesView? = nil
    
    let deviceMapper: DeviceMapper
    
    init(deviceService: DeviceService, deviceMapper: DeviceMapper) {
        self.deviceService = deviceService
        self.deviceMapper = deviceMapper
    }
    
    func onViewAppear() {
        
        print("devices presenter view will appear")
        
        deviceService.getDevices { devices, error in
            
            if (error == nil) {
                
                let deviceTypes = devices.map { self.deviceMapper.from(cachedDevice: $0) }
                    
                self.devicesView?.showDevices(devices: deviceTypes)
                
            } else {
                self.devicesView?.showError(message: error!.message)
            }
        }
        
    }
    
    func onViewDisappear() {
        
    }

    func deviceClicked(id: String) {
        
    }

    func deviceGroupClicked(type: String) {
        
    }
    
    func setView(view: DevicesView) {
        self.devicesView = view
    }
    
}

import Foundation

class ProfileDevicesPresenter : DevicesPresenter {

    let deviceService: DeviceService
    
    var devicesView: DevicesView? = nil
    
    let deviceMapper: DeviceMapper
    
    init(deviceService: DeviceService, deviceMapper: DeviceMapper) {
        self.deviceService = deviceService
        self.deviceMapper = deviceMapper
    }
    
    func onViewLoad() {
        
    }
    
    func onViewAppear() {
        
        print("devices presenter view will appear")
        
        getDevices()
        
    }
    
    private func getDevices() {
        
        deviceService.getDevices { devices, error in
            
            if (error == nil) {
                
                let deviceTypes = devices.map { self.deviceMapper.from(cachedDevice: $0) }
                    
                self.showDevices(devices: deviceTypes)
                
            } else {
                self.showError(message: error!.message)
            }
        }

    }
    
    func onViewDisappear() {

    }

    func deviceClicked(id: String) {
        
    }

    func deviceGroupClicked(type: String) {
        
    }
    
    func showDevices(devices: [ProfileDevice]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.devicesView?.showDevices(devices: devices)
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.devicesView?.showError(message: message)
        }
    }
    
    func setView(view: DevicesView) {
        self.devicesView = view
    }
    
}

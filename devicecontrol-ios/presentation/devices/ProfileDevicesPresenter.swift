import Foundation
import UIKit

class ProfileDevicesPresenter : DevicesPresenter {

    let deviceService: DeviceService
    
    var devicesView: DevicesView? = nil
    
    let deviceMapper: DeviceMapper
    
    let viewFactory: DeviceViewFactory
    
    let deepLinkManager: DeepLinkManager
    
    let router: Router
    
    init(router: Router, deviceService: DeviceService, deviceMapper: DeviceMapper, viewFactory: DeviceViewFactory, deepLinkManager: DeepLinkManager) {
        self.deviceService = deviceService
        self.deviceMapper = deviceMapper
        self.viewFactory = viewFactory
        self.deepLinkManager = deepLinkManager
        self.router = router
    }
    
    func onViewLoad() {
        
        loadContent()
        
    }
    
    private func loadContent() {
            
        if let deviceUrl = deepLinkManager.getPendingDeviceUrl() {

            loadDeviceDeepLink(deviceUrl: deviceUrl)
            
        }
        
    }
    
    private func loadDeviceDeepLink(deviceUrl: (String, URL)) {
        
        deviceService.getSavedDevices { [weak self] devices, error in
            
            guard let self = self else { return }
            
            if devices.count > 0 {
                var selectedDevice: ProfileDevice? = nil
                for device in devices {
                    
                    let profileDevice = self.deviceMapper.from(cachedDevice: device)
                    if deviceUrl.0 == profileDevice.deviceId {
                        selectedDevice = profileDevice
                        break
                    }
                }
                if let loadedDevice = selectedDevice {
                    print("deep linking device details for \(deviceUrl.0)")
                    self.pushDeviceDetails(profileDevice: loadedDevice, url: deviceUrl.1)
                }
            }
            
        }
        
    }
    
    
    func onViewAppear() {
        
        print("devices presenter view will appear")
        
        getDevices()
        
    }
    
    func onRefresh() {
        getDevices()
    }
    
    private func pushDeviceDetails(profileDevice: ProfileDevice, url: URL) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let view = self.devicesView {
                self.router.routeToViewController(self.viewFactory.detailsViewControllerFor(device: profileDevice, withUrl: url), from: view)
            }
        }
        
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

    func deviceClicked(_ device: ProfileDevice) {
        if let view = devicesView {
            let details = viewFactory.detailsViewControllerFor(device: device, withUrl: nil)
            router.routeToViewController(details, from: view)
        }
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
    
    func tableViewCellFor(device: ProfileDevice, tableView: UITableView) -> UITableViewCell {
        return viewFactory.tableViewCellFor(device: device, tableView: tableView)
    }
    
}

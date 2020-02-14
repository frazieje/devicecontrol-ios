//
//  ProfileDevicesPresenter.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/12/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

class ProfileDevicesPresenter : DevicesPresenter {
    
    let deviceService: DeviceService
    
    let devicesView: DevicesView
    
    let deviceMapper: DeviceMapper
    
    init(deviceService: DeviceService, deviceMapper: DeviceMapper, devicesView: DevicesView) {
        self.deviceService = deviceService
        self.devicesView = devicesView
        self.deviceMapper = deviceMapper
    }
    
    func viewWillAppear() {
        
        deviceService.getDevices { (devices, error) -> Void in
            if (error == nil) {
                
                let deviceTypes = devices.map { self.deviceMapper.from(cachedDevice: $0) }
                    
                self.devicesView.showDevices(devices: deviceTypes)
                
            } else {
                self.devicesView.showError(message: error!.message)
            }
        }
        
    }
    

    func viewDidAppear() {
        
        print("DevicesPresenter viewDidAppear")
        
    }
    
    
}

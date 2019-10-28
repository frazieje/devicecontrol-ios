//
//  ProfileDeviceService.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/13/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

class ProfileDeviceService : DeviceService {
    
    let deviceApi: DeviceApi
    let devicesRepo: Repository<[CachedDevice]>
    
    init(deviceApi: DeviceApi, repositoryFactory: RepositoryFactory) {
        self.deviceApi = deviceApi
        self.devicesRepo = repositoryFactory.get()
    }
    
    func getDevices(_ completion: @escaping ([CachedDevice], DeviceServiceError?) -> Void) {
        deviceApi.getDevices(profileId: profileId) { (devices, error) -> Void in
            if (error == nil) {
                self.devicesRepo.put(key: profileId, value: devices)
                completion(devices, nil)
            } else {
                completion([], .ErrorFetchingDevices(""))
            }
        }
    }
    
    
}

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
    
    let cacheKey = "cachedDevicesList"
    
    init(deviceApi: DeviceApi, repositoryFactory: RepositoryFactory) {
        self.deviceApi = deviceApi
        self.devicesRepo = repositoryFactory.get()
    }
    
    func getDevices(_ completion: @escaping ([CachedDevice], DeviceServiceError?) -> Void) {
        if let cachedDevices = devicesRepo.get(key: cacheKey) {
            completion(cachedDevices, nil)
        } else {
            deviceApi.getDevices { (devices, error) -> Void in
                if (error == nil) {
                    _ = self.devicesRepo.put(key: self.cacheKey, value: devices)
                    completion(devices, nil)
                } else {
                    completion([], .ErrorFetchingDevices(""))
                }
            }
        }
    }
    
}

//
//  ProfileDeviceService.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/13/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

class ProfileDeviceService : DeviceService {
    
    let profileApi: ProfileApi
    let devicesCache: Cache<[CachedDevice]>
    
    let cacheKey = "cachedDevicesList"
    
    init(profileApi: ProfileApi, cacheFactory: CacheFactory) {
        self.profileApi = profileApi
        self.devicesCache = cacheFactory.get(prefix: "profileDeviceService_cache")
    }
    
    func getDevices(_ completion: @escaping ([CachedDevice], DeviceServiceError?) -> Void) {
        if let cachedDevices = devicesCache.get(key: cacheKey) {
            completion(cachedDevices, nil)
        } else {
            profileApi.getDevices { (devices, error) -> Void in
                if (error == nil) {
                    _ = self.devicesCache.put(key: self.cacheKey, value: devices)
                    completion(devices, nil)
                } else {
                    completion([], .ErrorFetchingDevices(""))
                }
            }
        }
    }
    
}

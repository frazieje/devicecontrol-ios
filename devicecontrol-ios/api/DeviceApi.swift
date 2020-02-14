//
//  DevicesApi.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/12/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

protocol DeviceApi {
    
    func getDevices(_ completion: @escaping ([CachedDevice], DeviceApiError?) -> Void)
    
    func login(username: String, password: String, _ completion: @escaping (ProfileLogin?, DeviceApiError?) -> Void)
    
}

enum DeviceApiError: Equatable, Error
{
    case HttpError(String)
}


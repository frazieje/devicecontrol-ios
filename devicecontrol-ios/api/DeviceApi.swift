//
//  DevicesApi.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/12/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

protocol DeviceApi {
    
    func getDevices(profileId: String, _ completion: @escaping ([CachedDevice], DeviceApiError?) -> Void)
    
    func login(profileId: String, username: String, password: String, _ completion: @escaping )
    
}

enum DeviceApiError: Equatable, Error
{
    case HttpError(String)
}


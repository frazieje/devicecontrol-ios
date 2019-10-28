//
//  DeviceListInteractor.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/7/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

protocol DeviceService {
    func getDevices(_ completion: @escaping ([CachedDevice], DeviceServiceError?) -> Void)
}

enum DeviceServiceError: Equatable, Error
{
    case ErrorFetchingDevices(String)
    
    var message: String {
        get {
            switch self {
                case .ErrorFetchingDevices(let value): return "Error fetching devices: \(value)"
            }
        }
    }
}

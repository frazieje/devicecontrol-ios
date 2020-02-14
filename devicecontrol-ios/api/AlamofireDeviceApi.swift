//
//  AlamofireDeviceApi.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/21/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireDeviceApi : DeviceApi {
    
    func login(username: String, password: String, _ completion: @escaping (ProfileLogin?, DeviceApiError?) -> Void) {
        
    }
    
    func getDevices(_ completion: @escaping ([CachedDevice], DeviceApiError?) -> Void) {
        
    }
    
}

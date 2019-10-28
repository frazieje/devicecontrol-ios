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
    
    func getDevices(profileId: String, _ completion: @escaping ([CachedDevice], DeviceApiError?) -> Void) {
        AF.request(<#T##url: URLConvertible##URLConvertible#>)
    }
    
}

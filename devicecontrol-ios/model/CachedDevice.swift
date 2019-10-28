//
//  CachedDevice.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/12/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

struct CachedDevice : Codable {
    var type: DeviceType
    var address: EUI48Address
    var cachedDate: Date
    var cachedMessageList: [CachedMessage]
}

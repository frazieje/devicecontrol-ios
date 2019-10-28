//
//  Device.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/12/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

struct Device : Codable {
    var type: DeviceType
    var address: EUI48Address
}

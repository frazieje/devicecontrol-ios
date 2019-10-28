//
//  GasCylinder.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/26/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

struct GasCylinder : ProfileDevice {
    
    var deviceId: String
    
    var name: String
    
    var lastUpdated: Date
    
    var capacity: Float?
    
    var level: Float?
    
}

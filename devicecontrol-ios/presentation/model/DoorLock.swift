//
//  ProfileDevices.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/26/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

struct DoorLock : ProfileDevice {
    
    enum State : Int {
        case locked = 3
        case unlocked = 0
        case locking = 1
        case unlocking = 2
        case unknown = 5
    }
    
    var deviceId: String
    
    var name: String
    
    var description: String?
    
    var lastUpdated: Date
    
    var state: State
    
}

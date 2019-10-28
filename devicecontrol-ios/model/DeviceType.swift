//
//  DeviceType.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/12/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

enum DeviceType : Int, Codable {
    
    case door_lock = 0x4f
    case window_shade = 0x6b
    case gas_cylinder = 0x2d
    
    func description() -> String {
        switch self {
        case .door_lock:
            return "Door Lock"
        case .window_shade:
            return "Window Shade"
        case .gas_cylinder:
            return "Gas Cylinder"
        }
    }
    
    static func from(string: String) -> DeviceType? {
        return DeviceType(rawValue: Int(string, radix: 16)!)
    }
    
    func asString() -> String {
        String(format: "%02hhx", rawValue)
    }
    
}

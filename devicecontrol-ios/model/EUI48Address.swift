//
//  EUI48Address.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/12/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

struct EUI48Address : Codable {
    
    var data: Data
    var name: String?
    var address: String?
    
    public func asString() -> String {
        data.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

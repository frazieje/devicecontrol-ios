//
//  Message.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/7/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

struct Message: Codable {
    var topic: String
    var payload: Data?
    var headers: Dictionary<String, AnyCodable>?
}

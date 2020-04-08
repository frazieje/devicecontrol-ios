//
//  Permission.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 9/29/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

struct Permission: Codable {
    var type: PermissionType
    var deviceId: String
}

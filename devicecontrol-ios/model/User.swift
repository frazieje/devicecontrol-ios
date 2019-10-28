//
//  User.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 8/31/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: String
    var firstName: String?
    var lastName: String?
    var email: String?
    var permissions: [Permission]?
}

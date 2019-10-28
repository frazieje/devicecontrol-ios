//
//  UserLogin.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 9/29/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

struct UserLogin: Codable {
    var tokenKey: String
    var refreshToken: String
    var user: User
}

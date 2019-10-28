//
//  CachedMessage.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/9/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

struct CachedMessage : Codable {
    var cachedMessage: Message
    var cachedDate: Date
}

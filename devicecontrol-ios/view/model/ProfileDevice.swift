//
//  ProfileDevice.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/27/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

protocol ProfileDevice {

    var deviceId: String { get }
    var name: String { get }
    var lastUpdated: Date { get }

}

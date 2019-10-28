//
//  DevicesView.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/12/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

protocol DevicesView {
    func showDevices(devices: [ProfileDevice])
    func showError(message: String)
}

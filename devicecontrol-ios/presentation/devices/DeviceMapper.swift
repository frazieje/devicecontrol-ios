//
//  DeviceFactory.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/27/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

protocol DeviceMapper {
    func from(cachedDevice: CachedDevice) -> ProfileDevice
}

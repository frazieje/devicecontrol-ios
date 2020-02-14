//
//  ProfileDeviceMapper.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/27/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

class ProfileDeviceMapper : DeviceMapper {
    
    func from(cachedDevice: CachedDevice) -> ProfileDevice {
        
            let deviceId = cachedDevice.type.asString() + cachedDevice.address.asString()
        
            let name = cachedDevice.address.name ?? ""
            
            switch cachedDevice.type {
                
            case .door_lock:

                let lastMessage = cachedDevice.cachedMessageList.first {
                    $0.cachedMessage.topic.hasSuffix(".o.lock.state")
                }
                
                let stateString = String(bytes: lastMessage?.cachedMessage.payload ?? Data(), encoding: .utf8) ?? "5"
                
                let stateInt = Int(stateString) ?? 5
                
                let lockState = DoorLock.State(rawValue: stateInt) ?? DoorLock.State.unknown
                
                let updatedDate = lastMessage?.cachedDate ?? cachedDevice.cachedDate
                
                return DoorLock(deviceId: deviceId, name: name, lastUpdated: updatedDate, state: lockState)
                
            case .window_shade:
                
                let lastMessage = cachedDevice.cachedMessageList.first {
                    $0.cachedMessage.topic.hasSuffix(".o.shade.state")
                }
                
                let stateString = String(bytes: lastMessage?.cachedMessage.payload ?? Data(), encoding: .utf8) ?? ""
                
                let stateFloat = Float(stateString)
                
                let updatedDate = lastMessage?.cachedDate ?? cachedDevice.cachedDate
                
                return WindowShade(deviceId: deviceId, name: name, lastUpdated: updatedDate, state: stateFloat)
                
            case .gas_cylinder:

                let lastMessage = cachedDevice.cachedMessageList.first {
                    $0.cachedMessage.topic.hasSuffix(".o.state")
                }
                
                let stateString = String(bytes: lastMessage?.cachedMessage.payload ?? Data(), encoding: .utf8) ?? ""
                
                let stateArray = stateString.split(separator: ":")
                
                let levelFloat = Float(stateArray[0])
                
                let capacityFloat = Float(stateArray[1])
                
                let updatedDate = lastMessage?.cachedDate ?? cachedDevice.cachedDate
                
                return GasCylinder(deviceId: deviceId, name: name, lastUpdated: updatedDate, capacity: capacityFloat, level: levelFloat)
                
            }

    }
    
}

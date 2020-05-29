import Foundation

class ProfileDeviceMapper : DeviceMapper {
    
    func from(cachedDevice: CachedDevice) -> ProfileDevice {
        
        let deviceId = cachedDevice.type.toHexString() + cachedDevice.address.asString()
        
            let name = cachedDevice.address.name ?? ""
            
            switch cachedDevice.type {
                
            case .door_lock:

                let lastStateMessages = cachedDevice.cachedMessageList
                    .filter { item in
                        return item.cachedMessage.topic.hasSuffix(".o.lock.state")
                    }
                
                let lastStateMesssage = lastStateMessages.first
                
                let stateString = String(bytes: lastStateMesssage?.cachedMessage.payload ?? Data(), encoding: .utf8) ?? "5"
                
                let stateInt = Int(stateString) ?? 5
                
                let lockState = DoorLock.State(rawValue: stateInt) ?? DoorLock.State.unknown
                
                var prevLockStateIndex: Int?
                
                for (index, message) in lastStateMessages.enumerated() {
                    
                    let prevStateString = String(bytes: message.cachedMessage.payload ?? Data(), encoding: .utf8) ?? "5"
                    
                    let prevStateInt = Int(prevStateString) ?? 5
                    
                    let prevLockState = DoorLock.State(rawValue: prevStateInt) ?? DoorLock.State.unknown
                    
                    if prevLockState != lockState {
                        prevLockStateIndex = index
                        break
                    }
                    
                }
                
                let updatedDate = lastStateMesssage?.cachedDate ?? cachedDevice.cachedDate
                
                var lastStateChange: Date?
                
                if let prevIdx = prevLockStateIndex {
                    
                    if (prevIdx - 1) >= 0 && (prevIdx - 1) < lastStateMessages.count {
                        lastStateChange = lastStateMessages[prevIdx - 1].cachedDate
                    }
                    
                }
                
                return DoorLock(deviceId: deviceId, name: name, lastUpdated: updatedDate, lastStateChange: lastStateChange, state: lockState)
                
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

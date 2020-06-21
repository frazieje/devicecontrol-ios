import Foundation

class ProfileDeviceMapper : DeviceMapper {

    func from(cachedDevice: CachedDevice) -> ProfileDevice {
        
        let deviceId = cachedDevice.type.toHexString() + cachedDevice.address.asString()
        
        let name = cachedDevice.address.name ?? ""
            
        switch cachedDevice.type {
                
            case .door_lock:

                return ProfileDoorLockMapper().from(cachedDevice: cachedDevice, deviceId: deviceId, name: name)
            
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

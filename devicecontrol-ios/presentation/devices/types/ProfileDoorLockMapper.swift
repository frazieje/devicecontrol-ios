import Foundation

class ProfileDoorLockMapper : DoorLockMapper {

    func from(cachedDevice: CachedDevice, deviceId: String, name: String) -> DoorLock {
        
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
        
        let stateChangeHistory = from(cachedMessageList: cachedDevice.cachedMessageList)
        
        return DoorLock(deviceId: deviceId, name: name, lastUpdated: updatedDate, lastStateChange: lastStateChange, state: lockState, history: stateChangeHistory)
    }
    
    func from(cachedMessageList: [CachedMessage]) -> [DoorLockStateChange] {
        
        let lastStateMessages = cachedMessageList
            .filter { item in
                return item.cachedMessage.topic.hasSuffix(".o.lock.state")
            }
        
        var stateChangeHistory: [DoorLockStateChange] = []
        
        var lastLockState: DoorLock.State?
        
        lastStateMessages.reversed().forEach { message in
            
            let currentStateString = String(bytes: message.cachedMessage.payload ?? Data(), encoding: .utf8) ?? "5"
            
            let currentStateInt = Int(currentStateString) ?? 5
            
            let currentLockState = DoorLock.State(rawValue: currentStateInt) ?? DoorLock.State.unknown
            
            if lastLockState == nil || (lastLockState != currentLockState) {

                stateChangeHistory.append(DoorLockStateChange(date: message.cachedDate, state: currentLockState, user: ""))
                lastLockState = currentLockState
                
            }
            
        }
        
        return stateChangeHistory.reversed()
    }
    
    
    
    
}

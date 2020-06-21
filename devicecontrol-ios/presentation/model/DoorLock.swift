import Foundation

struct DoorLock : ProfileDevice {
    
    public static let stateTopic = "lock.state"
    public static let lockCommand = 1
    public static let unlockCommand = 0

    enum State : Int {
        case locked = 3
        case unlocked = 0
        case locking = 1
        case unlocking = 2
        case unknown = 5
    }
    
    var deviceId: String
    
    var name: String
    
    var description: String?
    
    var lastUpdated: Date
    
    var lastStateChange: Date?
    
    var state: State
    
    var history: [DoorLockStateChange]
    
    func stateAndMessageFrom(url: URL) -> (State, DeviceMessage)? {
        
        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
            let path = components.path,
            let host = components.host,
            let params = components.queryItems else {
                return nil
        }
        
        if let urlState = params.first(where: { $0.name == "state" })?.value {
            
            if let rawIntValue = Int(urlState) {
                if let currentState = DoorLock.State(rawValue: rawIntValue) {
                    if currentState != .locked && currentState != .unlocked {
                        return nil
                    }
                    let nextState: DoorLock.State = currentState == .locked ? .unlocked : .locked
                    if let nextMessage = messageFor(lockState: nextState) {
                        return (nextState, nextMessage)
                    }
                    return nil
                }
            }
            return nil
        } else {
            return nil
        }
    }
    
    func messageFor(lockState: State) -> DeviceMessage? {
        
        if lockState != .locked && lockState != .unlocked {
            return nil
        }
        
        let stringCommand = "\(lockState == .locked ? DoorLock.lockCommand : DoorLock.unlockCommand)"
        
        let data = Data(stringCommand.utf8)
        
        let message = Message(topic: DoorLock.stateTopic, payload: data)
        
        return DeviceMessage(deviceId: deviceId, message: message)
        
    }
    
}

struct DoorLockStateChange {
    var date: Date
    var state: DoorLock.State
    var user: String?
}

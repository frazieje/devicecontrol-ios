import Foundation

struct DoorLock : ProfileDevice {
    
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
    
}

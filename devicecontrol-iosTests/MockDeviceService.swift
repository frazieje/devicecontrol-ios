import Foundation

@testable import devicecontrol_ios

class MockDeviceService : DeviceService {
    
    private let serialQueue = DispatchQueue(label: "mockDeviceServiceQueue")
    
    private var getDevicesCalls: Int = 0
    
    private var publishCalls: [DeviceMessage] = []
    
    init() {
        
    }
    
    func getDevices(_ completion: @escaping ([CachedDevice], DeviceServiceError?) -> Void) {
        serialQueue.sync {
            getDevicesCalls += 1
            completion([], nil)
        }
    }
    
    func publish(message: DeviceMessage, _ completion: @escaping (DeviceServiceError?) -> Void) {
        serialQueue.sync {
            publishCalls.append(message)
            completion(nil)
        }
    }
    
    func getPublishCalls() -> [DeviceMessage] {
        return publishCalls
    }

}

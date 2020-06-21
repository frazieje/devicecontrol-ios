protocol DeviceService {
    func getDevices(_ completion: @escaping ([CachedDevice], DeviceServiceError?) -> Void)
    func getSavedDevices(_ completion: @escaping ([CachedDevice], DeviceServiceError?) -> Void)
    func publish(message: DeviceMessage, _ completion: @escaping (DeviceServiceError?) -> Void)
    func getDeviceLog(id: String, _ completion: @escaping ([CachedMessage], DeviceServiceError?) -> Void)
}

enum DeviceServiceError: Equatable, Error
{
    case ErrorFetchingDevices(String)
    case ErrorFetchingDeviceLog(String)
    case ErrorPublishingDeviceMessage(String)
    
    var message: String {
        get {
            switch self {
                case .ErrorFetchingDevices(let value): return "Error fetching devices: \(value)"
                case .ErrorFetchingDeviceLog(let value): return "Error fetching deviceLog: \(value)"
                case .ErrorPublishingDeviceMessage(let value): return "Error publishing device message: \(value)"
            }
        }
    }
}

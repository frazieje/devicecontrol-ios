protocol DeviceService {
    func getDevices(_ completion: @escaping ([CachedDevice], DeviceServiceError?) -> Void)
}

enum DeviceServiceError: Equatable, Error
{
    case ErrorFetchingDevices(String)
    
    var message: String {
        get {
            switch self {
                case .ErrorFetchingDevices(let value): return "Error fetching devices: \(value)"
            }
        }
    }
}

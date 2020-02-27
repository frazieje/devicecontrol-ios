protocol DeviceApi {
    
    func getDevices(_ completion: @escaping ([CachedDevice], DeviceApiError?) -> Void)
    
}

enum DeviceApiError: Equatable, Error
{
    case HttpError(String)
}


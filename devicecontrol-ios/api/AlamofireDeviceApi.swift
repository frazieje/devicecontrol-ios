import Alamofire

class AlamofireDeviceApi : DeviceApi {
    
    func getDevices(_ completion: @escaping ([CachedDevice], DeviceApiError?) -> Void) {
        completion([], nil)
    }
    
}

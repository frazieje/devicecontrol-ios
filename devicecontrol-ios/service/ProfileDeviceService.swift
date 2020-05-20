import Foundation

class ProfileDeviceService : DeviceService {
    
    let apiFactory: ApiFactory
    let devicesCache: Cache<[CachedDevice]>
    
    private let loginRepository: ProfileLoginRepository
    
    private let requestQueue = DispatchQueue(label: "net.farsystem.devicecontrol.deviceRequestQueue", attributes: .concurrent)
    
    private let currentProfileLoginIdCache: Cache<Int64>
    
    let currentProfileLoginCacheKey = "currentProfileLogin"
    
    let cacheKey = "cachedDevicesList"
    
    init(apiFactory: ApiFactory, loginRepository: ProfileLoginRepository, cacheFactory: CacheFactory) {
        self.apiFactory = apiFactory
        self.loginRepository = loginRepository
        self.devicesCache = cacheFactory.get()
        self.currentProfileLoginIdCache = cacheFactory.get()
    }
    
    func getDevices(_ completion: @escaping ([CachedDevice], DeviceServiceError?) -> Void) {
        
        requestQueue.async { [weak self] in
            
            guard let self = self else { return }
            
            do {
                if let cachedDevices = self.devicesCache.get(key: self.cacheKey) {
                    completion(cachedDevices, nil)
                } else {
                    let id = self.currentProfileLoginIdCache.get(key: self.currentProfileLoginCacheKey)!
                    let login = try self.loginRepository.getBy(id: id)
                    self.apiFactory.profileApi(login: login).getDevices { (devices, error) -> Void in
                        if (error == nil) {
                            _ = self.devicesCache.put(key: self.cacheKey, value: devices)
                            completion(devices, nil)
                        } else {
                            completion([], .ErrorFetchingDevices("\(error!)"))
                        }
                    }
                }
            } catch {
                completion([], .ErrorFetchingDevices("\(error)"))
            }
            
        }
        

    }
    
}

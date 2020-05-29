import Foundation

class ProfileDeviceService : DeviceService {
    
    let apiFactory: ApiFactory
    let devicesCache: Cache<CachedDevicesResponse>
    
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
                if let savedResponse = self.devicesCache.get(key: self.cacheKey) {
                    if savedResponse.retrieved.timeIntervalSinceNow > -3.0 {
                        completion(savedResponse.cachedDevices, nil)
                    } else {
                        try self.fetchDevices(completion)
                    }
                } else {
                    try self.fetchDevices(completion)
                }
            } catch {
                completion([], .ErrorFetchingDevices("\(error)"))
            }
            
        }
        

    }
    
    private func fetchDevices(_ completion: @escaping ([CachedDevice], DeviceServiceError?) -> Void) throws {
        let id = self.currentProfileLoginIdCache.get(key: self.currentProfileLoginCacheKey)!
        let login = try self.loginRepository.getBy(id: id)
        self.apiFactory.profileApi(login: login).getDevices { (devices, error) -> Void in
            if (error == nil) {
                _ = self.devicesCache.put(key: self.cacheKey, value: CachedDevicesResponse(retrieved: Date(), cachedDevices: devices))
                completion(devices, nil)
            } else {
                completion([], .ErrorFetchingDevices("\(error!)"))
            }
        }
    }
    
}

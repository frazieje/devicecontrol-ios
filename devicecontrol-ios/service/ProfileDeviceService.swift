import Foundation

class ProfileDeviceService : DeviceService {

    let apiFactory: ApiFactory
    
    let devicesCache: Cache<CachedDevicesResponse>
    
    let deviceLogCache: Cache<[CachedMessage]>
    
    private let loginRepository: ProfileLoginRepository
    
    private let requestQueue = DispatchQueue(label: "net.farsystem.devicecontrol.deviceRequestQueue", attributes: .concurrent)
    
    private let currentProfileLoginIdCache: Cache<Int64>
    
    let currentProfileLoginCacheKey = "currentProfileLogin"
    
    let deviceListCacheKey = "cachedDevicesList_"
    
    let deviceLogCacheKey = "deviceLogCacheKey_"
    
    init(apiFactory: ApiFactory, loginRepository: ProfileLoginRepository, cacheFactory: CacheFactory) {
        self.apiFactory = apiFactory
        self.loginRepository = loginRepository
        self.devicesCache = cacheFactory.get()
        self.deviceLogCache = cacheFactory.get()
        self.currentProfileLoginIdCache = cacheFactory.get()
    }
    
    func getDevices(_ completion: @escaping ([CachedDevice], DeviceServiceError?) -> Void) {
        
        requestQueue.async { [weak self] in
            
            guard let self = self else { return }
            
            do {
                let loginId = self.currentProfileLoginIdCache.get(key: self.currentProfileLoginCacheKey)!
                if let savedResponse = self.devicesCache.get(key: "\(self.deviceListCacheKey)\(loginId)") {
                    if savedResponse.retrieved.timeIntervalSinceNow > -3.0 {
                        completion(savedResponse.cachedDevices, nil)
                    } else {
                        try self.fetchDevices(loginId, completion)
                    }
                } else {
                    try self.fetchDevices(loginId, completion)
                }
            } catch {
                completion([], .ErrorFetchingDevices("\(error)"))
            }
            
        }
        

    }
    
    private func fetchDevices(_ loginId: Int64, _ completion: @escaping ([CachedDevice], DeviceServiceError?) -> Void) throws {
        let login = try self.loginRepository.getBy(id: loginId)
        self.apiFactory.profileApi(responseQueue: requestQueue, login: login).getDevices { (devices, error) -> Void in
            if (error == nil) {
                _ = self.devicesCache.put(key: "\(self.deviceListCacheKey)\(loginId)", value: CachedDevicesResponse(retrieved: Date(), cachedDevices: devices))
                completion(devices, nil)
            } else {
                completion([], .ErrorFetchingDevices("\(error!)"))
            }
        }
    }
    
    func getSavedDevices(_ completion: @escaping ([CachedDevice], DeviceServiceError?) -> Void) {
        
        requestQueue.async { [weak self] in
            
            guard let self = self else { return }
            
            let loginId = self.currentProfileLoginIdCache.get(key: self.currentProfileLoginCacheKey)!
            
            if let savedResponse = self.devicesCache.get(key: "\(self.deviceListCacheKey)\(loginId)") {
                completion(savedResponse.cachedDevices, nil)
            } else {
                completion([], nil)
            }
            
        }
        
    }
    
    
    func publish(message: DeviceMessage, _ completion: @escaping (DeviceServiceError?) -> Void) {
        
        requestQueue.async { [weak self] in
            
            guard let self = self else { return }
            
            do {
                let id = self.currentProfileLoginIdCache.get(key: self.currentProfileLoginCacheKey)!
                let login = try self.loginRepository.getBy(id: id)
                self.apiFactory.profileApi(responseQueue: self.requestQueue, login: login).postProfileMessage(toDeviceId: message.deviceId, message: message.message) { error in
                    if (error == nil) {
                        completion(nil)
                    } else {
                        completion(.ErrorPublishingDeviceMessage("\(error!)"))
                    }
                }
            } catch {
                completion(.ErrorPublishingDeviceMessage("\(error)"))
            }
            
        }
        
    }
    
    func getDeviceLog(id: String, _ completion: @escaping ([CachedMessage], DeviceServiceError?) -> Void) {
        
        requestQueue.async { [weak self] in
            
            guard let self = self else { return }
            
            do {
                let currentProfileId = self.currentProfileLoginIdCache.get(key: self.currentProfileLoginCacheKey)!
                let login = try self.loginRepository.getBy(id: currentProfileId)
                self.apiFactory.profileApi(responseQueue: self.requestQueue, login: login).getDeviceLog(id: id) { result, error in
                    if (error == nil) {
                        //_ = self.devicesCache.put(key: self.cacheKey, value: CachedDevicesResponse(retrieved: Date(), cachedDevices: devices))
                        completion(result, nil)
                    } else {
                        completion([], .ErrorFetchingDevices("\(error!)"))
                    }
                }
            } catch {
                completion([], .ErrorFetchingDeviceLog("\(error)"))
            }
            
        }
        
    }
    
    
}

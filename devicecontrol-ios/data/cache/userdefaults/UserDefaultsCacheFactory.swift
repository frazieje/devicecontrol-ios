class UserDefaultsCacheFactory : CacheFactory {
    
    func get<T : Codable>(prefix: String) -> Cache<T> {
        return UserDefaultsCache<T>(suiteName: prefix)
    }
    
    func get<T>() -> Cache<T> where T : Decodable, T : Encodable {
        return get(prefix: "devicecontrol")
    }
    
}

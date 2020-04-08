class UserDefaultsCacheFactory : CacheFactory {
    
    func get<T : Codable>(prefix: String) -> Cache<T> {
        return UserDefaultsCache<T>(suiteName: prefix)
    }
    
}

protocol CacheFactory {
    func get<T : Codable>(prefix: String) -> Cache<T>
}

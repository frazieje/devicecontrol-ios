protocol CacheFactory {
    func get<T : Codable>(prefix: String) -> Cache<T>
    func get<T : Codable>() -> Cache<T>
}

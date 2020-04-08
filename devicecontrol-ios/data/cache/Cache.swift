class Cache<T> {
    
    func get(key: String) -> T? { return nil }
    func put(key: String, value: T) -> Bool { return false }
    func remove(key: String) -> Bool { return false }
    func getAll() -> [String : T] { return [:] }
    func clear() -> Bool { return false }
    
}

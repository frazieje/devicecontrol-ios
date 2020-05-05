import Foundation

class InMemoryCacheFactory : CacheFactory {

    var values: [String : Any] = [:]
    
    private let concurrentQueue =
    DispatchQueue(
      label: "com.spoohapps.devicecontrol.inMemoryCacheFactory",
      attributes: .concurrent)
    
    func get<T>(prefix: String) -> Cache<T> where T : Decodable, T : Encodable {
        var result: Cache<T>? = nil
        concurrentQueue.sync {
            result = self.values[prefix] as? Cache<T>
        }
        if let savedValue = result {
            return savedValue
        }
        concurrentQueue.sync(flags: .barrier) {
            result = InMemoryCache()
            self.values[prefix] = result
        }
        return result!
    }
    
    func get<T>() -> Cache<T> where T : Decodable, T : Encodable {
        return get(prefix: "devicecontrol")
    }
    
}

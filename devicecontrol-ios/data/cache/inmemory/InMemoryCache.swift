import Foundation

class InMemoryCache<T> : Cache<T> where T:Codable {
    
    var values: [String : T] = [:]
    
    private let concurrentQueue =
    DispatchQueue(
      label: "com.spoohapps.devicecontrol.inMemoryCache",
      attributes: .concurrent)

    
    override func get(key: String) -> T? {
        var result: T? = nil
        concurrentQueue.sync {
            result = self.values[key]
        }
        if let savedValue = result {
            return savedValue
        }
        return nil
    }
    
    override func put(key: String, value: T) -> Bool {
        concurrentQueue.async(flags: .barrier) { [weak self] in

            guard let self = self else {
              return
            }
            
            self.values[key] = value
            
        }
        return true
    }
    
    override func remove(key: String) -> Bool {
        concurrentQueue.async(flags: .barrier) { [weak self] in

            guard let self = self else {
              return
            }
            
            self.values.removeValue(forKey: key)
            
        }
        return true
    }
    
    override func clear() -> Bool {
        concurrentQueue.async(flags: .barrier) { [weak self] in

            guard let self = self else {
              return
            }
            
            self.values.removeAll()
            
        }
        return true
    }
    
    override func getAll() -> [String : T] {
        var result: [String : T]!
        concurrentQueue.sync {
            result = self.values
        }
        return result
    }
    
}


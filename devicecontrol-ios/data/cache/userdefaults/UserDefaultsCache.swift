import Foundation

class UserDefaultsCache<T> : Cache<T> where T:Codable {
    
    let encoder: JSONEncoder = JSONEncoder()
    let decoder: JSONDecoder = JSONDecoder()
    
    let userDefaults: UserDefaults
    
    let prefix: String
    
    let suiteName: String
    
    init(suiteName: String?) {
        self.suiteName = suiteName != nil ? suiteName! : "devicecontrol"
        self.userDefaults = suiteName != nil ? UserDefaults(suiteName: suiteName)! : UserDefaults.standard
        self.prefix = self.suiteName + "_"
    }
    
    override func get(key: String) -> T? {
        if let savedValue = userDefaults.object(forKey: prefix + key) as? Data {
            if let decoded = try? decoder.decode(T.self, from: savedValue) {
                return decoded
            }
        }
        return nil
    }
    
    override func put(key: String, value: T) -> Bool {
        if let encoded = try? encoder.encode(value) {
            userDefaults.set(encoded, forKey: prefix + key)
            return true
        } else {
            return false
        }
    }
    
    override func remove(key: String) -> Bool {
        userDefaults.removeObject(forKey: prefix + key)
        return true
    }
    
    override func clear() -> Bool {
        userDefaults.removePersistentDomain(forName: suiteName)
        return true
    }
    
    override func getAll() -> [String : T] {
        do {
            return try Dictionary(uniqueKeysWithValues: userDefaults.dictionaryRepresentation().filter { key, value in
                key.starts(with: prefix)
            }.map { key, value in
                let savedValue = value as! Data
                let decoded = try decoder.decode(T.self, from: savedValue)
                return (key, decoded)
            })
        } catch {
            return [:]
        }
        
    }
    
}

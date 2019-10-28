//
//  UserDefaultsRepository.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 9/2/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

class UserDefaultsRepository<T> : Repository<T> where T:Codable {
    
    let encoder: JSONEncoder = JSONEncoder()
    let decoder: JSONDecoder = JSONDecoder()
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    override func get(key: String) -> T? {
        if let savedValue = userDefaults.object(forKey: key) as? Data {
            if let decoded = try? decoder.decode(T.self, from: savedValue) {
                return decoded
            }
        }
        return nil
    }
    
    override func put(key: String, value: T) -> Bool {
        if let encoded = try? encoder.encode(value) {
            userDefaults.set(encoded, forKey: key)
            return true
        } else {
            return false
        }
    }
    
    override func remove(key: String) -> Bool {
        userDefaults.removeObject(forKey: key)
        return true
    }
    
}

//
//  File.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/13/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

class ProfileRepositoryFactory : RepositoryFactory {
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults;
    }
    
    func get<T : Codable>() -> Repository<T> {
        return UserDefaultsRepository<T>(userDefaults: userDefaults)
    }
    
}

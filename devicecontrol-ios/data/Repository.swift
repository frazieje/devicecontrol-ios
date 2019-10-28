//
//  Repository.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 9/2/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

class Repository<T> {
    
    func get(key: String) -> T? { return nil }
    func put(key: String, value: T) -> Bool { return false }
    func remove(key: String) -> Bool { return false }
    
}

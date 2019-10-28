//
//  RepositoryFactory.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 10/13/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

protocol RepositoryFactory {
    func get<T : Codable>() -> Repository<T>
}

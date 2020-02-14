//
//  ProfileService.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 11/3/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import Foundation

protocol ProfileService {
    
    func getProfiles(_ completion: @escaping ([ProfileLogin], ProfileServiceError?) -> Void)

}

enum ProfileServiceError: Equatable, Error
{
    case ErrorFetchingProfiles(String)
    
    var message: String {
        get {
            switch self {
                case .ErrorFetchingProfiles(let value): return "Error fetching profiles: \(value)"
            }
        }
    }
}

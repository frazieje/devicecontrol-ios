//
//  LoginService.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 2/14/20.
//  Copyright © 2020 Spoohapps, Inc. All rights reserved.
//

import Foundation

protocol LoginService {
    func getLogin(_ completion: @escaping (ProfileLogin, LoginServiceError?) -> Void)
}

enum LoginServiceError: Equatable, Error
{
    case ErrorFetchingLogin(String)
    
    var message: String {
        get {
            switch self {
                case .ErrorFetchingLogin(let value): return "Error fetching login: \(value)"
            }
        }
    }
}

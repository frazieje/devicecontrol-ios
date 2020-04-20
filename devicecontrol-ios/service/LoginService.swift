//
//  LoginService.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 2/14/20.
//  Copyright © 2020 Spoohapps, Inc. All rights reserved.
//

import Foundation

protocol LoginService {
    
    func getActiveLogin(_ completion: @escaping (ProfileLogin?, LoginServiceError?) -> Void)
    
    func setActiveLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void)
    
    func getAllLogins(_ completion: @escaping ([ProfileLogin], LoginServiceError?) -> Void)
    
    func saveLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void)
    
    func removeLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void)
    
    func clearLogins(_ completion: @escaping (Bool, LoginServiceError?) -> Void)
    
    func login(_ username: String, _ password: String, _ profileId: String, _ servers: [ProfileServer], _ completion: @escaping (ProfileLogin?, LoginServiceError?) -> Void)
    
}

enum LoginServiceError: Equatable, Error
{
    case ErrorRefreshingLogin(String)
    case ErrorFetchingLogins(String)
    case ErrorCompletingLogin(String)
    case ErrorCreatingOrUpdatingLogin(String)
    case ErrorSettingActiveLogin(String)
    case ErrorFetchingActiveLogin(String)
    case ErrorRemovingLogin(String)
    case ErrorClearingLogins(String)
    
    var message: String {
        get {
            switch self {
                case .ErrorRefreshingLogin(let value): return "Error refreshing login: \(value)"
                case .ErrorFetchingLogins(let value): return "Error fetching logins: \(value)"
                case .ErrorCompletingLogin(let value): return "Error completing login \(value)"
                case .ErrorCreatingOrUpdatingLogin(let value): return "Error creating or updating login \(value)"
                case .ErrorSettingActiveLogin(let value): return "Error settings active login \(value)"
                case .ErrorFetchingActiveLogin(let value): return "Error fetching active login \(value)"
                case .ErrorRemovingLogin(let value): return "Error removing login \(value)"
                case .ErrorClearingLogins(let value): return "Error clearing logins \(value)"
            }
        }
    }
}

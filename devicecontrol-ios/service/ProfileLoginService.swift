//
//  ProfileLoginService.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 2/14/20.
//  Copyright © 2020 Spoohapps, Inc. All rights reserved.
//

import Foundation

class ProfileLoginService : LoginService {
    
    let loginRepo: Repository<ProfileLogin>
    
    let currentLoginKey = "currentLoginProfile"
    
    init(repositoryFactory: RepositoryFactory) {
        loginRepo = repositoryFactory.get()
    }

    func getLogin(_ user: User, _ profile: Profile, _ completion: @escaping (ProfileLogin?, LoginServiceError?) -> Void) {
        
        if let profileLogin = loginRepo.get(key: currentLoginKey) {
            completion(profileLogin, nil)
        } else {
            completion(nil, .ErrorFetchingLogin("No "))
        }
    }
    
    func setLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void) {
        completion(true, nil)
    }
    
}

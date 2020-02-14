//
//  ProfileLoginService.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 2/14/20.
//  Copyright © 2020 Spoohapps, Inc. All rights reserved.
//

import Foundation

class ProfileLoginService : LoginService {
    
    let profileLogin: ProfileLogin
    
    init(profileLogin: ProfileLogin) {
        self.profileLogin = profileLogin
    }

    func getLogin(_ completion: @escaping (ProfileLogin, LoginServiceError?) -> Void) {
        completion(profileLogin, nil)
    }
    
}

//
//  ProfileLoginService.swift
//  devicecontrol-ios
//
//  Created by Joel Frazier on 2/14/20.
//  Copyright © 2020 Spoohapps, Inc. All rights reserved.
//

import Foundation

class ProfileLoginService : LoginService {

    let loginCache: Cache<ProfileLogin>
    
    let oAuthApi: OAuthApi
    
    init(cacheFactory: CacheFactory, oAuthApi: OAuthApi) {
        loginCache = cacheFactory.get(prefix: "profileLoginService_logins")
        self.oAuthApi = oAuthApi
    }
    
    func setActiveLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void) {
        
    }
    
    func getActiveLogin(_ completion: @escaping (ProfileLogin?, LoginServiceError?) -> Void) {
        
    }
    
    func getAllLogins(_ completion: @escaping ([ProfileLogin], LoginServiceError?) -> Void) {
        
    }
    
    func saveLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void) {
        
    }
    
    func removeLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void) {
        
    }
    
    func clearLogins(_ completion: @escaping (Bool, LoginServiceError?) -> Void) {
        
    }
    
    func login(_ servers: [ProfileServer], _ user: User, _ profileId: String, _ password: String, _ completion: @escaping (ProfileLogin?, LoginServiceError?) -> Void) {
        
    }
    
//    func getActiveLogin(_ completion: @escaping (ProfileLogin?, LoginServiceError?) -> Void) {
//
//        let activeKey = "profileLogin_activeLogin"
//
//        if activeLogin == nil {
//
//            DispatchQueue.global(qos: .default).async { [weak self] in
//
//                guard let strongSelf = self else { return }
//
//                if let key = strongSelf.activeIdCache.get(key: activeKey) {
//
//                    strongSelf.activeLock.lock()
//                    strongSelf.activeLogin = key
//                    strongSelf.activeLock.unlock()
//
//                    if let login = strongSelf.loginsDict[key] {
//
//                        completion(login, nil)
//
//                    } else {
//                        if let savedLogin = strongSelf.loginRepo.get(key: key) {
//                            completion(savedLogin, nil)
//                        } else {
//                            completion(nil, .ErrorFetchingActiveLogin("problem finding active profile in backing storage"))
//                        }
//                    }
//
//
//                } else {
//                    completion(nil, .ErrorFetchingActiveLogin("problem retrieving active profile from backing storage"))
//                }
//            }
//
//
//    }
//
//    func setActiveLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void) {
//
//        let activeKey = "profileLogin_activeLogin"
//
//        let loginKey = "profileLogin_\(login.userid)_\(login.profileid)_\(login.host)"
//
//        if loginsDict[loginKey] != nil {
//
//            DispatchQueue.global(qos: .default).async { [weak self] in
//
//                guard let strongSelf = self else { return }
//
//                if strongSelf.activeIdRepo.put(key: activeKey, value: loginKey) {
//                    strongSelf.activeLock.lock()
//                    strongSelf.activeLogin = loginKey
//                    strongSelf.activeLock.unlock()
//                    completion(true, nil)
//                } else {
//                    completion(false, .ErrorSettingActiveLogin("problem saving active profile to backing storage"))
//                }
//            }
//        } else {
//            DispatchQueue.global(qos: .default).async { completion(false, .ErrorSettingActiveLogin(""))}
//        }
//
//    }
//
//    func saveLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void) {
//
//        let loginKey = "profileLogin_\(login.userid)_\(login.profileid)_\(login.host)"
//
//        DispatchQueue.global(qos: .default).async { [weak self] in
//
//            guard let strongSelf = self else { return }
//
//            if strongSelf.loginRepo.put(key: loginKey, value: login) {
//                strongSelf.dictLock.lock()
//                strongSelf.loginsDict[loginKey] = login
//                strongSelf.dictLock.unlock()
//                completion(true, nil)
//            } else {
//                completion(false, .ErrorCreatingOrUpdatingLogin("error saving value"))
//            }
//        }
//
//    }
//
//    func removeLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void) {
//
//        let loginKey = "profileLogin_\(login.userid)_\(login.profileid)_\(login.host)"
//
//        DispatchQueue.global(qos: .default).async { [weak self] in
//
//            guard let strongSelf = self else { return }
//
//            if strongSelf.loginRepo.remove(key: loginKey) {
//                strongSelf.dictLock.lock()
//                strongSelf.loginsDict.removeValue(forKey: loginKey)
//                strongSelf.dictLock.unlock()
//                completion(true, nil)
//            } else {
//                completion(false, .ErrorRemovingLogin("error saving value"))
//            }
//        }
//    }
//
//    func clearLogins(_ completion: @escaping (Bool, LoginServiceError?) -> Void) {
//
//        DispatchQueue.global(qos: .default).async { [weak self] in
//
//            guard let strongSelf = self else { return }
//
//            if strongSelf.loginRepo.clear() {
//                strongSelf.dictLock.lock()
//                strongSelf.loginsDict.removeAll()
//                strongSelf.dictLock.unlock()
//                completion(true, nil)
//            } else {
//                completion(false, .ErrorRemovingLogin("error saving value"))
//            }
//        }
//    }
//
//    func getAllLogins(_ completion: @escaping ([ProfileLogin], LoginServiceError?) -> Void) {
//        if !loginsDict.isEmpty {
//            DispatchQueue.global(qos: .default).async { [weak self] in
//                guard let strongSelf = self else { return }
//                completion(Array(strongSelf.loginsDict.values), nil)
//            }
//        } else {
//            DispatchQueue.global(qos: .default).async { [weak self] in
//
//                guard let strongSelf = self else { return }
//
//                strongSelf.dictLock.lock()
//                strongSelf.loginsDict = strongSelf.loginRepo.getAll()
//                let result = Array(strongSelf.loginsDict.values)
//                strongSelf.dictLock.unlock()
//
//                completion(result, nil)
//            }
//        }
//    }
//
//    func login(_ host: String, _ secure: Bool, _ user: User, _ profile: Profile, _ password: String, _ completion: @escaping (ProfileLogin?, LoginServiceError?) -> Void) {
//
//        let req = OAuthResourceOwnerGrantRequest(
//                                secure: secure,
//                                host: host,
//                                clientId: profile.id,
//                                username: user.email,
//                                password: password)
//
//        oAuthApi.login(req) { result, error in
//
//            if error == nil, let oAuthGrant = result {
//
//                let login = ProfileLogin(profileid: profile.id, userid: user.id, host: host, secure: secure, oAuthGrant: oAuthGrant)
//                let loginKey = "profileLogin_\(login.userid)_\(login.profileid)_\(login.host)"
//
//                DispatchQueue.global(qos: .default).async { [weak self] in
//
//                    guard let strongSelf = self else { return }
//
//                    if strongSelf.loginRepo.put(key: loginKey, value: login) {
//                        strongSelf.dictLock.lock()
//                        strongSelf.loginsDict[loginKey] = login
//                        strongSelf.dictLock.unlock()
//                        completion(login, nil)
//                    } else {
//                        completion(nil, .ErrorCompletingLogin("error saving login"))
//                    }
//
//                }
//
//            } else {
//                completion(nil, .ErrorCompletingLogin("login failed"))
//            }
//
//        }
//
//    }
//
//    func refreshLogin(_ login: ProfileLogin, _ completion: @escaping (ProfileLogin?, LoginServiceError?) -> Void) {
//
//        let req = OAuthRefreshTokenGrantRequest(
//                                secure: login.secure,
//                                host: login.host,
//                                clientId: login.profileid,
//                                refreshToken: login.oAuthGrant.refreshToken)
//
//        oAuthApi.refreshToken(req) { result, error in
//
//            if error == nil, let oAuthGrant = result {
//                let login = ProfileLogin(profileid: login.profileid, userid: login.userid, host: login.host, secure: login.secure, oAuthGrant: oAuthGrant)
//                let loginKey = "profileLogin_\(login.userid)_\(login.profileid)_\(login.host)"
//
//                DispatchQueue.global(qos: .default).async { [weak self] in
//
//                    guard let strongSelf = self else { return }
//
//                    if strongSelf.loginRepo.put(key: loginKey, value: login) {
//                        strongSelf.dictLock.lock()
//                        strongSelf.loginsDict[loginKey] = login
//                        strongSelf.dictLock.unlock()
//                        completion(login, nil)
//                    } else {
//                        completion(nil, .ErrorCompletingLogin("error saving login"))
//                    }
//                }
//            } else {
//                completion(nil, .ErrorCompletingLogin("login failed"))
//            }
//        }
//
//    }
    
}

import Foundation

class ProfileLoginService : LoginService {

    private let apiFactory: ApiFactory
    
    private let loginRequestQueue = DispatchQueue(label: "net.farsystem.devicecontrol.loginRequestQueue", attributes: .concurrent)
    
    private let loginResponseQueue = DispatchQueue(label: "net.farsystem.devicecontrol.loginResponseQueue")
    
    private let loginRepository: ProfileLoginRepository
    
    private let currentProfileLoginIdCache: Cache<Int64>
    
    let currentProfileLoginCacheKey = "currentProfileLogin"
    
    init(apiFactory: ApiFactory, loginRepository: ProfileLoginRepository, cacheFactory: CacheFactory) {
        self.apiFactory = apiFactory
        self.loginRepository = loginRepository
        self.currentProfileLoginIdCache = cacheFactory.get()
    }
    
    func setActiveLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void) {
        
    }
    
    func getActiveLogin(_ completion: @escaping (ProfileLogin?, LoginServiceError?) -> Void) {
        
        loginRequestQueue.async { [weak self] in
            
            guard let self = self else { return }
            
            if let currentActiveProfileId = self.getCurrentProfileLoginId() {
                
                do {
                    
                    completion(try self.loginRepository.getBy(id: currentActiveProfileId), nil)
                
                } catch {
                    
                    completion(nil, .errorFetchingActiveLogin("\(error)"))
                    
                }
                
            } else {
                
                completion(nil, .errorFetchingActiveLogin("Unable to find active login"))
                
            }
            
        }
        
    }
    
    func getAllLogins(_ completion: @escaping ([ProfileLogin], LoginServiceError?) -> Void) {
        
    }
    
    func saveLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void) {
        
    }
    
    func removeLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void) {
        
    }
    
    func clearLogins(_ completion: @escaping (Bool, LoginServiceError?) -> Void) {
        
    }
    
    func login(_ loginRequest: LoginRequest, _ result: ((LoginResult) -> Void)?, _ completion: @escaping ([LoginResult]) -> Void) {
                
        loginRequestQueue.async { [weak self] in
            
            guard let self = self else { return }
            
            let loginRequests = DispatchGroup()
            
            var loginResults: [LoginResult] = []

            loginRequest.servers.forEach { server in
                let request = OAuthResourceOwnerGrantRequest(clientId: loginRequest.profileId, username: loginRequest.username, password: loginRequest.password)
                loginRequests.enter()
                self.apiFactory.oAuthApi(server: server).login(request) { [weak self] token, apiError in
                    guard let self = self else { return }
                    var loginResult: LoginResult?
                    if let token = token {
                        let loginToken = LoginToken(
                            clientId: loginRequest.profileId,
                            tokenKey: token.tokenKey,
                            tokenType: token.tokenType,
                            refreshToken: token.refreshToken,
                            expiresIn: token.expiresIn,
                            issuedAt: token.issuedAt)
                        loginResult = LoginResult(error: apiError == nil ? nil : .errorCompletingLogin(apiError!.message), server: server, token: loginToken)
                    } else {
                        loginResult = LoginResult(error: apiError == nil ? nil : .errorCompletingLogin(apiError!.message), server: server, token: nil)
                    }
                    result?(loginResult!)
                    self.loginResponseQueue.async {
                        loginResults.append(loginResult!)
                        loginRequests.leave()
                    }
                }
            }
            
            loginRequests.wait()
            
            if (loginResults.count > 0) {
                
                var loginTokens: [ProfileServer : LoginToken] = [:]
                
                loginResults.filter { $0.error == nil && $0.token != nil }.forEach { result in
                    loginTokens[result.server] = result.token!
                }
            
                let profileLogin = ProfileLogin(profileId: loginRequest.profileId, name: nil, description: nil, username: loginRequest.username, loginTokens: loginTokens)
                
                if let newLogin = try? self.loginRepository.put(profileLogin) {
                    _ = self.saveCurrentProfileLoginId(newLogin.id)
                }
                
            }
            
            completion(loginResults)
                
        }

    }
    
    private func saveCurrentProfileLoginId(_ id: Int64) -> Bool {
        return currentProfileLoginIdCache.put(key: currentProfileLoginCacheKey, value: id)
    }
    
    private func getCurrentProfileLoginId() -> Int64? {
        return currentProfileLoginIdCache.get(key: currentProfileLoginCacheKey)
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

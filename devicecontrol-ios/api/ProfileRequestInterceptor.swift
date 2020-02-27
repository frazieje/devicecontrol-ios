import Alamofire

class ProfileRequestInterceptor : RetryPolicy {
    
    private let lock = NSLock()
    
    private let repositoryKey: String
    
    private let repository: Repository<ProfileLogin>
    
    private var profileLogin: ProfileLogin?
    
    private var isRefreshing = false
    
    private let oAuthApi: OAuthApi
    
    private var queuedRetries: [(RetryResult) -> Void] = []
    
    private let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.allowsCellularAccess = false

        return Session(configuration: configuration)
    }()
    
    init(profile: Profile, user: User, oAuthGrant: OAuthGrant, repositoryFactory: RepositoryFactory, oAuthApi: OAuthApi) {
        
        self.repository = repositoryFactory.get()
        self.oAuthApi = oAuthApi
        let host = URLComponents(string: oAuthApi.getBaseUrl())?.host
        self.repositoryKey = "profileLogin_\(profile.id)_\(host!)"
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        if let login = getProfileLogin() {
            urlRequest.headers.add(.authorization(bearerToken: login.userLogin.tokenKey))
        }

        completion(.success(urlRequest))
    }
    
    override func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        lock.lock() ; defer { lock.unlock() }
        
        if
            let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == 401 {
            queuedRetries.append(completion)
            
            if !isRefreshing {
                
                refreshToken { [weak self] succeeded, accessToken, refreshToken in
                    
                    guard let strongSelf = self else { return }
                    
                    strongSelf.lock.lock() ; defer { strongSelf.lock.unlock() }
                    
                    if let accessToken = accessToken, let refreshToken = refreshToken {
                        if let login = strongSelf.profileLogin {
                            let newLogin = ProfileLogin(profile: <#T##Profile#>, userLogin: <#T##UserLogin#>)
                            strongSelf.setProfileLogin(profileLogin: login)
                        }
                    }
                    
                    strongSelf.queuedRetries.forEach {
                        $0(succeeded ? .retry : .doNotRetry)
                    }
                    
                    strongSelf.queuedRetries.removeAll()
                    
                }
                
            }
            
        } else {
            completion(.doNotRetry)
        }
    }
    
    private func getProfileLogin() -> ProfileLogin? {
        
        if let login = profileLogin {
            return login
        }
        
        profileLogin = repository.get(key: repositoryKey)
        
        return profileLogin
    }
    
    private func setProfileLogin(profileLogin: ProfileLogin) {
        
        if let login = repository.put(key: repositoryKey, value: profileLogin) {
            self.profileLogin = profileLogin
        }
        
    }
    
    private func refreshToken(completion: @escaping (_ succeeded: Bool, _ accessToken: String?, _ refreshToken: String?) -> Void) {
        
        guard !isRefreshing else { return }

        isRefreshing = true
        
        if let refreshToken = profileLogin?.userLogin.refreshToken {
            
            oAuthApi.refreshToken(profile.id, refreshToken) { [weak self] result, error in
                
                guard let strongSelf = self else { return }
                
                if error == nil, let oAuthGrant = result {
                    completion(true, oAuthGrant.tokenKey, oAuthGrant.refreshToken)
                } else {
                    completion(false, nil, nil)
                }
                
                strongSelf.isRefreshing = false
            }
            
        } else {
            isRefreshing = false
            completion(false, nil, nil)
        }

//        let urlString = "\(baseURLString)/oauth2/token"
//
//        let parameters: [String: String] = [
//            "refresh_token": profileLogin?.userLogin.refreshToken ?? "",
//            "client_id": clientId,
//            "grant_type": "refresh_token"
//        ]
//
//        session.request(urlString, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)
//            .responseDecodable { [weak self] (response: DataResponse<OAuthGrant, AFError>) in
//
//                guard let strongSelf = self else { return }
//
//                if let oauthGrant = response.value {
//                    completion(true, oauthGrant.tokenKey, oauthGrant.refreshToken)
//                } else {
//                    completion(false, nil, nil)
//                }
//
//                strongSelf.isRefreshing = false
//
//            }
        
    }
    
    
    
}

import Foundation
import Alamofire

class ProfileRequestInterceptor : RetryPolicy {

    private var loginToken: LoginToken
    
    private let oAuthApi: OAuthApi
    
    private let tokenRepository: LoginTokenRepository
    
    private var isRefreshing = false
    
    private var queuedRetries: [(RetryResult) -> Void] = []
    
    private let concurrentQueue =
    DispatchQueue(
      label: "net.spoohapps.devicecontrol.requestInterceptor",
      attributes: .concurrent)
    
    init(loginToken: LoginToken, oAuthApi: OAuthApi, tokenRepository: LoginTokenRepository) {
        self.loginToken = loginToken
        self.oAuthApi = oAuthApi
        self.tokenRepository = tokenRepository
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        concurrentQueue.async { [weak self] in
            
            guard let self = self else { return }
            
            var urlRequest = urlRequest

            urlRequest.headers.add(.authorization(bearerToken: self.loginToken.tokenKey))

            completion(.success(urlRequest))
            
        }
        

    }
    
    override func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        concurrentQueue.async(flags: .barrier) { [weak self] in
            
            guard let self = self else { return }
        
            if
                let response = request.task?.response as? HTTPURLResponse,
                response.statusCode == 401 {
                
                self.queuedRetries.append(completion)
                
                if !self.isRefreshing {
                    
                    let req = OAuthRefreshTokenGrantRequest(
                                            clientId: self.loginToken.clientId,
                                            refreshToken: self.loginToken.refreshToken)
                    
                    self.oAuthApi.refreshToken(req) { [weak self] result, error in
                        
                        guard let self = self else { return }
                        
                        self.concurrentQueue.async(flags: .barrier) { [weak self] in
                            
                            guard let self = self else { return }
                        
                            var succeeded: Bool = false
                            
                            if error == nil, let newToken = result {
                                
                                let semaphore = DispatchSemaphore(value: 0)
                                
                                self.tokenRepository.put(newToken) { success in
                                    succeeded = success
                                    semaphore.signal()
                                }
                                
                                semaphore.wait()
                                
                                self.loginToken = newToken
                            }
                            
                            self.queuedRetries.forEach {
                                $0(succeeded ? .retry : .doNotRetry)
                            }
                            
                            self.queuedRetries.removeAll()
                            
                            self.isRefreshing = false
                            
                        }
                        
                    }
                    
                }
                
            } else {
                completion(.doNotRetry)
            }
        }
    }

}


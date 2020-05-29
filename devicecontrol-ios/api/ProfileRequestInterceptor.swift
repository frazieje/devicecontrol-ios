import Foundation
import Alamofire

class ProfileRequestInterceptor : RequestInterceptor {

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
            
            print("adapting request \(urlRequest.url?.absoluteString) with \(self.loginToken.tokenKey)")

            completion(.success(urlRequest))
            
        }
        

    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        concurrentQueue.async(flags: .barrier) { [weak self] in
            
            guard let self = self else { return }
            
            print("retrying request \((request.task?.response as? HTTPURLResponse)?.statusCode) \(request.request?.url?.absoluteString)")

            if
                let response = request.task?.response as? HTTPURLResponse,
                response.statusCode == 401 {
                
                print("refreshing token due to 401")
                
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
                                
                                let storeToken = LoginToken(
                                                        id: self.loginToken.id,
                                                        clientId: self.loginToken.clientId,
                                                        tokenKey: newToken.tokenKey,
                                                        tokenType: newToken.tokenType,
                                                        refreshToken: newToken.refreshToken,
                                                        expiresIn: newToken.expiresIn,
                                                        issuedAt: newToken.issuedAt)
                                
                                succeeded = true
                                
                                do {
                                    self.loginToken = try self.tokenRepository.put(storeToken)
                                } catch {
                                    succeeded = false
                                }
                                
                                print("refreshi token due to 401")
                            
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


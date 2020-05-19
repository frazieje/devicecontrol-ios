import Foundation
import Alamofire

class AlamofireOAuthApi : OAuthApi {
    
    private let urlPath = "/oauth2/token"
    
    private let session: Session
    
    private let server: ProfileServer
    
    init(session: Session, server: ProfileServer) {
        self.session = session
        self.server = server
    }
    
    func login(_ request: OAuthResourceOwnerGrantRequest, _ completion: @escaping (LoginToken?, OAuthApiError?) -> Void) {
        
        do {
            
            let url = try server.asURL().appendingPathComponent(urlPath)

            var urlRequest = URLRequest(url: url)
            
            urlRequest.method = .post
            
            urlRequest = try URLEncodedFormParameterEncoder().encode(request, into: urlRequest)
            
            session.request(urlRequest).responseDecodable(of: LoginToken.self) { response in
                do {
                    var token = try response.result.get()
                    token.clientId = request.clientId
                    completion(token, nil)
                } catch {
                    completion(nil, .HttpError("\(error)"))
                }
            }
            
        } catch {
            completion(nil, .ErrorFormingRequest("\(error)"))
        }
        
    }
    
    func refreshToken(_ request: OAuthRefreshTokenGrantRequest, _ completion: @escaping (LoginToken?, OAuthApiError?) -> Void) {
        
        do {
            
            let url =  try server.asURL().appendingPathComponent(urlPath)

            var urlRequest = URLRequest(url: url)
            
            urlRequest.method = .post
            
            urlRequest = try URLEncodedFormParameterEncoder().encode(request, into: urlRequest)
            
            session.request(urlRequest).responseDecodable(of: LoginToken.self) { response in
                do {
                    try completion(response.result.get(), nil)
                } catch {
                    completion(nil, .HttpError("\(error)"))
                }
            }
            
        } catch {
            completion(nil, .ErrorFormingRequest("\(error)"))
        }
    }
    
    
}

import Foundation
import Alamofire

class AlamofireOAuthApi : OAuthApi {
    
    private let urlPath = "/oauth2/token"
    
    private let session: Session
    
    private let server: ProfileServer
    
    private let decoder = JSONDecoder()
    
    private let responseQueue: DispatchQueue
    
    init(responseQueue: DispatchQueue, session: Session, server: ProfileServer) {
        self.responseQueue = responseQueue
        self.session = session
        self.server = server
        decoder.dateDecodingStrategy = .millisecondsSince1970
    }
    
    func login(_ request: OAuthResourceOwnerGrantRequest, _ completion: @escaping (OAuthToken?, OAuthApiError?) -> Void) {
        
        do {
            
            let url = try server.asURL().appendingPathComponent(urlPath)

            var urlRequest = URLRequest(url: url)
            
            urlRequest.method = .post
            
            urlRequest = try URLEncodedFormParameterEncoder().encode(request, into: urlRequest)
            
            session.request(urlRequest).responseDecodable(of: OAuthToken.self, queue: responseQueue, decoder: decoder) { response in
                do {
                    let token = try response.result.get()
                    print("token for \(urlRequest.url?.absoluteString) = \(token.tokenKey)")
                    completion(token, nil)
                } catch {
                    completion(nil, .HttpError("\(error)"))
                }
            }
            
        } catch {
            completion(nil, .ErrorFormingRequest("\(error)"))
        }
        
    }
    
    func refreshToken(_ request: OAuthRefreshTokenGrantRequest, _ completion: @escaping (OAuthToken?, OAuthApiError?) -> Void) {
        
        do {
            
            let url =  try server.asURL().appendingPathComponent(urlPath)

            var urlRequest = URLRequest(url: url)
            
            urlRequest.method = .post
            
            urlRequest = try URLEncodedFormParameterEncoder().encode(request, into: urlRequest)
            
            session.request(urlRequest).responseDecodable(of: OAuthToken.self, queue: responseQueue, decoder: decoder) { response in
                do {
                    let token = try response.result.get()
                    print("refreshed token for \(urlRequest.url?.absoluteString) = \(token.tokenKey)")
                    completion(token, nil)
                } catch {
                    completion(nil, .HttpError("\(error)"))
                }
            }
            
        } catch {
            completion(nil, .ErrorFormingRequest("\(error)"))
        }
    }
    
    
}

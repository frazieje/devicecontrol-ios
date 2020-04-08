import Foundation
import Alamofire

class AlamofireOAuthApi : OAuthApi {
    
    private let urlPath = "/oauth2/token"
    
    func login(_ request: OAuthResourceOwnerGrantRequest, _ completion: @escaping (LoginToken?, OAuthApiError?) -> Void) {
        
        let url = URL(string: (request.secure ? "https://" : "http://") + request.host)!.appendingPathComponent(urlPath)

        var urlRequest = URLRequest(url: url)
        
        urlRequest.method = .post
        
        do {
            
            urlRequest = try URLEncodedFormParameterEncoder().encode(request, into: urlRequest)
            
            AF.request(urlRequest).responseDecodable(of: LoginToken.self) { response in
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
    
    func refreshToken(_ request: OAuthRefreshTokenGrantRequest, _ completion: @escaping (LoginToken?, OAuthApiError?) -> Void) {
        
        let url = URL(string: (request.secure ? "https://" : "http://") + request.host)!.appendingPathComponent(urlPath)

        var urlRequest = URLRequest(url: url)
        
        urlRequest.method = .post
        
        do {
            
            urlRequest = try URLEncodedFormParameterEncoder().encode(request, into: urlRequest)
            
            AF.request(urlRequest).responseDecodable(of: LoginToken.self) { response in
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

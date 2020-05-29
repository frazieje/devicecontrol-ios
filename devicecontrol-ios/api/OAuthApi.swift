protocol OAuthApi {
    
    func login(_ request: OAuthResourceOwnerGrantRequest, _ completion: @escaping (OAuthToken?, OAuthApiError?) -> Void)
    
    func refreshToken(_ request: OAuthRefreshTokenGrantRequest, _ completion: @escaping (OAuthToken?, OAuthApiError?) -> Void)
    
}

enum OAuthApiError: Equatable, Error
{
    case HttpError(String)
    case ErrorFormingRequest(String)
    
    var message: String {
        get {
            switch self {
                case .HttpError(let value): return "Http Error: \(value)"
                case .ErrorFormingRequest(let value): return "Error forming request \(value)"
            }
        }
    }
}

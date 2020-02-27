protocol OAuthApi {
    
    func login(_ username: String, _ password: String, _ clientId: String, _ completion: @escaping (OAuthGrant?, OAuthApiError?) -> Void)
    
    func refreshToken(_ clientId: String, _ refreshToken: String, _ completion: @escaping (OAuthGrant?, OAuthApiError?) -> Void)
    
    func getBaseUrl() -> String
    
}

enum OAuthApiError: Equatable, Error
{
    case HttpError(String)
}

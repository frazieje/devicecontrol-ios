struct OAuthRefreshTokenGrantRequest : Codable {
    
    let grantType = "refresh_token"
    var clientId: String
    var refreshToken: String
    
    enum CodingKeys : String, CodingKey {
        case grantType = "grant_type"
        case clientId = "client_id"
        case refreshToken = "refresh_token"
    }
}

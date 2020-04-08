struct OAuthRefreshTokenGrantRequest : Codable {
    var secure: Bool
    var host: String
    var clientId: String
    var refreshToken: String
}


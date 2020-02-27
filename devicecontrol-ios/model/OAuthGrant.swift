struct OAuthGrant : Codable {
    var host: String
    var tokenKey: String
    var tokenType: String
    var refreshToken: String
    var expiresIn: Int64
}

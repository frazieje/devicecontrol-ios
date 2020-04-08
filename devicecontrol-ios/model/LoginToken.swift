struct LoginToken : Codable {
    var clientId: String
    var server: ProfileServer
    var tokenKey: String
    var tokenType: String
    var refreshToken: String
    var expiresIn: Int64
    var issuedAt: Int64
}

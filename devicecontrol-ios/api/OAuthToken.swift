import Foundation

struct OAuthToken : Codable {
    var tokenKey: String
    var tokenType: String
    var refreshToken: String
    var expiresIn: Int64
    var issuedAt: Date
}

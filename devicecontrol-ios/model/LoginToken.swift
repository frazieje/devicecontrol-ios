import Foundation

struct LoginToken : Codable {
    var id: Int64 = -1
    var clientId: String
    var tokenKey: String
    var tokenType: String
    var refreshToken: String
    var expiresIn: Int64
    var issuedAt: Date
}

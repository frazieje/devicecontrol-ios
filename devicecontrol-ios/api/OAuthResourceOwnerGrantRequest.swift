import Alamofire

struct OAuthResourceOwnerGrantRequest : Codable {
    var secure: Bool
    var host: String
    var clientId: String
    var username: String
    var password: String
}

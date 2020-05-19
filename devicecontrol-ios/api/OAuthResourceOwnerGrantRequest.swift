struct OAuthResourceOwnerGrantRequest : Codable {
    
    let grantType = "password"
    var clientId: String
    var username: String
    var password: String
    
    enum CodingKeys : String, CodingKey {
        case grantType = "grant_type"
        case clientId = "client_id"
        case username
        case password
    }
    
}

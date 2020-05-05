struct ProfileLogin: Codable {
    var id: Int64 = -1
    let profileId: String
    let name: String?
    let description: String?
    let username: String
    let loginTokens: [ProfileServer : LoginToken]
}

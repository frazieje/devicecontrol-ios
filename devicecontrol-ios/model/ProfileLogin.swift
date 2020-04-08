struct ProfileLogin: Codable {
    let profileId: String
    let name: String
    let description: String
    let username: String
    let loginTokens: [LoginToken]
}

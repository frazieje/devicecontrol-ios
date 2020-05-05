struct ProfileServer : Codable, Hashable, Equatable {
    var host: String
    var port: Int
    var secure: Bool
}


struct ProfileServer : Codable, Hashable {
    var host: String
    var port: Int
    var secure: Bool
}

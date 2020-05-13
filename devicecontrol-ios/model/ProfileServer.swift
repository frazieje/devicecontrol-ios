struct ProfileServer : Codable, Hashable, Equatable {
    var host: String
    var port: Int
    var secure: Bool
    
    func toString() -> String {
        let portStr = secure ? (port == 443 ? "" : ":\(port)") : (port == 80 ? "" : ":\(port)")
        return "http\(secure ? "s" : "")://\(host)\(portStr)".lowercased()
    }
}

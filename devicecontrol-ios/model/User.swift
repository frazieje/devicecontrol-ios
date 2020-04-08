struct User: Codable {
    var id: String
    var firstName: String?
    var lastName: String?
    var email: String
    var permissions: [Permission]
}

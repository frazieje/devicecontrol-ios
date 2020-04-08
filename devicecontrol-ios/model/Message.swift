import Foundation

struct Message: Codable {
    var topic: String
    var payload: Data?
    var headers: Dictionary<String, AnyCodable>?
}

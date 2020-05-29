import Foundation

struct EUI48Address : Codable, Equatable {
    
    var data: Data
    var name: String?
    var address: String?
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.data == rhs.data
    }
    
    public func asString() -> String {
        data.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}

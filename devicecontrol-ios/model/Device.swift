import Foundation

struct Device : Codable {
    var type: DeviceType
    var address: EUI48Address
    func id() -> String {
        return "\(type.toHexString())\(address.asString())"
    }
}

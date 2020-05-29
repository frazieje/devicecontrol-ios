import Foundation

struct CachedDevicesResponse : Codable {
    var retrieved: Date
    var cachedDevices: [CachedDevice]
}

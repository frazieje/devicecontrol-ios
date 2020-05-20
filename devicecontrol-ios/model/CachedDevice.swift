import Foundation

struct CachedDevice : Codable {
    var type: DeviceType
    var address: EUI48Address
    var cachedDate: Date
    var cachedMessageList: [CachedMessage]
}

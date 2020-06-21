import Foundation

protocol DeepLinkManager {
    func getPendingDeviceUrl() -> (String, URL)?
}

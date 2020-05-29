import Foundation

protocol ProfileDevice {
    
    var deviceId: String { get }
    var name: String { get }
    var lastUpdated: Date { get }
    
}

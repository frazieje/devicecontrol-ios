import Foundation

enum DeviceType : String, Codable {
    
    case door_lock
    case window_shade
    case gas_cylinder
    
    func displayName() -> String {
        switch self {
        case .door_lock:
            return "Door Lock"
        case .window_shade:
            return "Window Shade"
        case .gas_cylinder:
            return "Gas Cylinder"
        }
    }
    
    static func from(int: Int) -> DeviceType? {
        return dict()[int]
    }
    
    private static func dict() -> [Int : DeviceType] {
        return [
            0x4f : .door_lock,
            0x6b : .window_shade,
            0x2d : .gas_cylinder,
        ]
    }
    
    func toInt() -> Int {
        return DeviceType.dict().first { $0.value == self }!.key
    }
    
    static func fromHex(string: String) -> DeviceType? {
        return from(int: Int(string, radix: 16)!)
    }
    
    func toHexString() -> String {
        String(format: "%02hhx", toInt())
    }
    
}

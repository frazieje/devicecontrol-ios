protocol NearbyProfileService {
    
    func register(listener: NearbyProfileListener)
    
    func unregister(listener: NearbyProfileListener)
    
}

protocol NearbyProfileListener : AnyObject {
    func onResults(items: [ProfileServer])
}

enum NearbyProfileServiceError: Equatable, Error
{
    case ErrorFindingNearbyProfiles(String)
    
    var message: String {
        get {
            switch self {
                case .ErrorFindingNearbyProfiles(let value): return "Error finding nearby profiles: \(value)"
            }
        }
    }
}

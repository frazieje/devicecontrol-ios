protocol NearbyProfileService {
    
    func register(_ listener: @escaping ([String : [ProfileServer]]) -> Void) -> NearbyProfileServiceSubscription
    
    func unregister(_ subscription: NearbyProfileServiceSubscription)
    
}

protocol NearbyProfileServiceSubscription {
    func getTag() -> String
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

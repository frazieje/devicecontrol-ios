protocol LoginService {
    
    func getActiveLogin(_ completion: @escaping (ProfileLogin?, LoginServiceError?) -> Void)
    
    func setActiveLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void)
    
    func getAllLogins(_ completion: @escaping ([ProfileLogin], LoginServiceError?) -> Void)
    
    func saveLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void)
    
    func removeLogin(_ login: ProfileLogin, _ completion: @escaping (Bool, LoginServiceError?) -> Void)
    
    func clearLogins(_ completion: @escaping (Bool, LoginServiceError?) -> Void)
    
    func login(_ loginRequest: LoginRequest, _ result: ((LoginResult) -> Void)?, _ completion: @escaping ([LoginResult]) -> Void)
    
}

struct LoginResult
{
    var error: LoginServiceError?
    var server: ProfileServer
    var token: LoginToken?
}

enum LoginServiceError: Equatable, Error
{
    case errorFetchingLogins(String)
    case errorCompletingLogin(String)
    case errorCreatingOrUpdatingLogin(String)
    case errorSettingActiveLogin(String)
    case errorFetchingActiveLogin(String)
    case errorRemovingLogin(String)
    case errorClearingLogins(String)
    
    var message: String {
        get {
            switch self {
                case .errorFetchingLogins(let value): return "Error fetching logins: \(value)"
                case .errorCompletingLogin(let value): return "Error completing login \(value)"
                case .errorCreatingOrUpdatingLogin(let value): return "Error creating or updating login \(value)"
                case .errorSettingActiveLogin(let value): return "Error settings active login \(value)"
                case .errorFetchingActiveLogin(let value): return "Error fetching active login \(value)"
                case .errorRemovingLogin(let value): return "Error removing login \(value)"
                case .errorClearingLogins(let value): return "Error clearing logins \(value)"
            }
        }
    }
}

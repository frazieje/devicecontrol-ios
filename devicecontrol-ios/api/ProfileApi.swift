protocol ProfileApi {
    func getPing(_ completion: @escaping (String?, ProfileApiError?) -> Void)
    func getDevices(_ completion: @escaping ([CachedDevice], ProfileApiError?) -> Void)
}

enum ProfileApiError: Equatable, Error
{
    case UnknownError(String)
    case HttpError(String)
}

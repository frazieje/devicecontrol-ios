import Foundation

protocol ProfileApi {
    func getPing(_ completion: @escaping (String?, ProfileApiError?) -> Void)
    func getDevices(_ completion: @escaping ([CachedDevice], ProfileApiError?) -> Void)
    func getDeviceLog(id: String, _ completion: @escaping ([CachedMessage], ProfileApiError?) -> Void)
    func postProfileMessage(toDeviceId: String, message: Message, _ completion: @escaping (ProfileApiError?) -> Void)
}

enum ProfileApiError: Equatable, Error
{
    case UnknownError(String)
    case HttpError(String)
    case ErrorFormingRequest(String)
}

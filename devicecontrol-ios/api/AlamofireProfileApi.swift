import Foundation
import Alamofire

class AlamofireProfileApi : ProfileApi {

    private let profilePath = "profile"
    private let pingPath = "ping"
    private let devicesPath = "devices"
    private let deviceLogPath = "deviceLog"
    
    private let responseQueue: DispatchQueue
    private let session: Session
    private let serverUrl: URL
    private let profileId: String
    
    private let decoder = JSONDecoder()
    
    init(responseQueue: DispatchQueue, session: Session, server: ProfileServer, profileId: String) {
        self.responseQueue = responseQueue
        self.session = session
        self.serverUrl = try! server.asURL()
        self.profileId = profileId
        decoder.dateDecodingStrategy = .millisecondsSince1970
    }
    
    func getPing(_ completion: @escaping (String?, ProfileApiError?) -> Void) {
        let requestUrl = serverUrl.appendingPathComponent(pingPath)
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.method = .get
        session.request(urlRequest).responseDecodable(of: String.self, queue: responseQueue, decoder: decoder) { response in
            do {
                let result = try response.result.get()
                completion(result, nil)
            } catch {
                completion(nil, .HttpError("\(error)"))
            }
        }
    }
    
    func getDevices(_ completion: @escaping ([CachedDevice], ProfileApiError?) -> Void) {

        let requestUrl = serverUrl
            .appendingPathComponent(profilePath)
            .appendingPathComponent(profileId)
            .appendingPathComponent(devicesPath)
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.method = .get
        
        session.request(urlRequest).responseDecodable(of: [CachedDevice].self, queue: responseQueue, decoder: decoder) { response in
            do {
                let result = try response.result.get()
                print("\(result.count) devices from \(urlRequest.url?.absoluteString)")
                completion(result, nil)
            } catch {
                completion([], .HttpError("\(error)"))
            }
        }
        
    }
    
    func postProfileMessage(toDeviceId: String, message: Message, _ completion: @escaping (ProfileApiError?) -> Void) {
        
        let requestUrl = serverUrl
            .appendingPathComponent(profilePath)
            .appendingPathComponent(profileId)
            .appendingPathComponent(toDeviceId)
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.method = .post
        
        do {
            urlRequest = try JSONParameterEncoder().encode(message, into: urlRequest)
        } catch {
            completion(.ErrorFormingRequest("\(error)"))
        }
        
        session.request(urlRequest).response(queue: responseQueue) { data in
            if let response = data.response {
                if response.statusCode < 200 || response.statusCode > 299 {
                    completion(.HttpError("Error \(response.statusCode)"))
                } else {
                    completion(nil)
                }
            } else {
                completion(.UnknownError("Unknown request error"))
            }
        }
        
    }
    
    func getDeviceLog(id: String, _ completion: @escaping ([CachedMessage], ProfileApiError?) -> Void) {
        
        let requestUrl = serverUrl
            .appendingPathComponent(profilePath)
            .appendingPathComponent(profileId)
            .appendingPathComponent(deviceLogPath)
            .appendingPathComponent(id)
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.method = .get
        
        session.request(urlRequest).responseDecodable(of: [CachedMessage].self, queue: responseQueue, decoder: decoder) { response in
            do {
                let result = try response.result.get()
                completion(result, nil)
            } catch {
                completion([], .HttpError("\(error)"))
            }
        }
        
    }
    
    
}

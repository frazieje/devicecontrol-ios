import Foundation
import Alamofire

class AlamofireProfileApi : ProfileApi {

    private let profilePath = "profile"
    private let pingPath = "ping"
    private let devicesPath = "devices"
    
    private let session: Session
    private let serverUrl: URL
    private let profileId: String
    
    private let decoder = JSONDecoder()
    
    init(session: Session, server: ProfileServer, profileId: String) {
        self.session = session
        self.serverUrl = try! server.asURL()
        self.profileId = profileId
        decoder.dateDecodingStrategy = .millisecondsSince1970
    }
    
    func getPing(_ completion: @escaping (String?, ProfileApiError?) -> Void) {
        let requestUrl = serverUrl.appendingPathComponent(pingPath)
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.method = .get
        session.request(urlRequest).responseDecodable(of: String.self) { response in
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
        
        session.request(urlRequest).responseDecodable(of: [CachedDevice].self, decoder: decoder) { response in
            do {
                let result = try response.result.get()
                print("\(result.count) devices from \(urlRequest.url?.absoluteString)")
                completion(result, nil)
            } catch {
                completion([], .HttpError("\(error)"))
            }
        }
        
    }
    
}

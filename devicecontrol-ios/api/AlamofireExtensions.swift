import Foundation
import Alamofire

extension ProfileServer : URLConvertible {
    
    func asURL() throws -> URL {
        let port = self.secure ? (self.port == 443 ? "" : ":\(self.port)") : (self.port == 80 ? "" : ":\(self.port)")
        let url = URL(string: "http\(self.secure ? "s" : "")://\(self.host)\(port)")!
        return url.appendingPathComponent("devicecontrol")
    }
    
}

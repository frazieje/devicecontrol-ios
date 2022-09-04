import Foundation
import Alamofire

class AlamofireApiFactory : ApiFactory {
    
    private let serverResolver: ServerResolver
    
    private let tokenRepository: LoginTokenRepository
    
    private var profileSessions: [String : Session] = [:]
    
    private let queue = DispatchQueue(label: "net.farsystem.devicecontrol.apiFactory", attributes: .concurrent)
    
    private let refreshTokenFailureHandler: (ProfileLogin) -> Void
    
    init(serverResolver: ServerResolver, tokenRepository: LoginTokenRepository, _ refreshTokenFailureHandler: @escaping (ProfileLogin) -> Void) {
        self.serverResolver = serverResolver
        self.tokenRepository = tokenRepository
        self.refreshTokenFailureHandler = refreshTokenFailureHandler
    }
    
    func oAuthApi(responseQueue: DispatchQueue, server: ProfileServer) -> OAuthApi {
        return AlamofireOAuthApi(responseQueue: responseQueue, session: Session.default, server: server)
    }
    
    func profileApi(responseQueue: DispatchQueue, login: ProfileLogin) -> ProfileApi {
        var session: Session?
        let server = serverResolver.resolveFor(login: login)
        let token = login.loginTokens[server]!
        let hashCode = "\(login.id)\(server.hashValue)"
        queue.sync {
            session = profileSessions[hashCode]
        }
        if session == nil {
            queue.sync(flags: .barrier) {
                if let existing = profileSessions[hashCode] {
                    session = existing
                } else {
                    let oAuthApiForServer = oAuthApi(responseQueue: responseQueue, server: server)
                    session = Session(interceptor: ProfileRequestInterceptor(login: login, loginToken: token, oAuthApi: oAuthApiForServer, tokenRepository: tokenRepository, refreshTokenFailureHandler))
                    profileSessions[hashCode] = session
                }
            }
        }
        
        return AlamofireProfileApi(responseQueue: responseQueue, session: session!, server: server, profileId: login.profileId)
        
    }
    
}

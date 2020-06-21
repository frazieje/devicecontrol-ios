import XCTest

@testable import devicecontrol_ios

class ProfileLoginServiceTests : XCTestCase {
    
    private var loginService: ProfileLoginService? = nil
    
    private let cacheFactory: CacheFactory = InMemoryCacheFactory()
    
    private let repositoryFactory = TestRepositoryFactory()
    
    private let apiFactory = TestApiFactory()

    override func setUp() {
        loginService = ProfileLoginService(apiFactory: apiFactory, loginRepository: repositoryFactory.getProfileLoginRepository(), cacheFactory: cacheFactory)
        
    }

    override func tearDown() {
        
    }
    
    func testPerformsLogin() {
        
        let completionExpectation = self.expectation(description: "completionExpectation")
        
        let servers = [ProfileServer(host: "test.com", port: 443, secure: true), ProfileServer(host: "test2.com", port: 443, secure: true)]
        
        let request = LoginRequest(username: "name", password: "password", profileId: "47wfh47h", servers: servers)
        
        apiFactory.loginToken = LoginToken(clientId: "", tokenKey: "", tokenType: "", refreshToken: "", expiresIn: 0, issuedAt: Date())

        loginService?.login(request, nil) { results in
            completionExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertTrue(apiFactory.oAuthApiCalledWithServers.count == servers.count)
        
        XCTAssertTrue(apiFactory.oAuthApiCalledWithServers.allSatisfy { server in
            servers.contains(server)
        })
        
        XCTAssertTrue(apiFactory.oAuthApis.allSatisfy { api in
                   api.calledLoginWithRequest!.clientId == request.profileId
                && api.calledLoginWithRequest!.username == request.username
                && api.calledLoginWithRequest!.password == request.password
        })
        
        XCTAssertTrue(repositoryFactory.profileLoginRepository.putCalledWith?.profileId == request.profileId)
        
        let cache: Cache<Int64> = cacheFactory.get()
            
        XCTAssertTrue(cache.get(key: loginService!.currentProfileLoginCacheKey)! == -1)
        
    }
    
}

class TestOAuthApi : OAuthApi {
    
    private let loginToken: LoginToken?
    private let oAuthApiError: OAuthApiError?
    
    init(loginToken: LoginToken?, oAuthApiError: OAuthApiError?) {
        self.loginToken = loginToken
        self.oAuthApiError = oAuthApiError
    }
    
    var calledLoginWithRequest: OAuthResourceOwnerGrantRequest?
    
    var calledRefreshWithRequest: OAuthRefreshTokenGrantRequest?
    
    func login(_ request: OAuthResourceOwnerGrantRequest, _ completion: @escaping (OAuthToken?, OAuthApiError?) -> Void) {
        calledLoginWithRequest = request
        let token =  OAuthToken(tokenKey: loginToken!.tokenKey, tokenType: loginToken!.tokenType, refreshToken: loginToken!.refreshToken, expiresIn: loginToken!.expiresIn, issuedAt: loginToken!.issuedAt)
        completion(token, oAuthApiError)
    }
    
    func refreshToken(_ request: OAuthRefreshTokenGrantRequest, _ completion: @escaping (OAuthToken?, OAuthApiError?) -> Void) {
        calledRefreshWithRequest = request
        let token =  OAuthToken(tokenKey: loginToken!.tokenKey, tokenType: loginToken!.tokenType, refreshToken: loginToken!.refreshToken, expiresIn: loginToken!.expiresIn, issuedAt: loginToken!.issuedAt)
        completion(token, oAuthApiError)
    }

}

class TestProfileApi: ProfileApi {

    func getPing(_ completion: @escaping (String?, ProfileApiError?) -> Void) {
        completion(nil, nil)
    }
    
    func getDevices(_ completion: @escaping ([CachedDevice], ProfileApiError?) -> Void) {
        completion([], nil)
    }
    
    func postProfileMessage(toDeviceId: String, message: Message, _ completion: @escaping (ProfileApiError?) -> Void) {
        completion(nil)
    }
    
}

class TestApiFactory : ApiFactory {
    
    var loginToken: LoginToken?
    var oAuthApiError: OAuthApiError?
    
    var oAuthApis: [TestOAuthApi] = []
    
    var oAuthApiCalledWithServers: [ProfileServer] = []
    
    func oAuthApi(responseQueue: DispatchQueue, server: ProfileServer) -> OAuthApi {
        oAuthApiCalledWithServers.append(server)
        let api = TestOAuthApi(loginToken: loginToken, oAuthApiError: oAuthApiError)
        oAuthApis.append(api)
        return api
    }
    
    func profileApi(responseQueue: DispatchQueue, login: ProfileLogin) -> ProfileApi {
        return TestProfileApi()
    }

}

class TestProfileLoginRepository : ProfileLoginRepository {
    func getBy(id: Int64) throws -> ProfileLogin {
        return ProfileLogin(profileId: "", name: "", description: "", username: "", loginTokens: [:])
    }
    
    
    var putCalledWith: ProfileLogin?
    
    func getBy(profileId: String, _ completion: @escaping ([ProfileLogin]) -> Void) {
        
    }
    
    func getBy(profileName: String, _ completion: @escaping ([ProfileLogin]) -> Void) {
        
    }
    
    func getAll(_ completion: @escaping ([ProfileLogin]) -> Void) {
        
    }
    
    func put(_ item: ProfileLogin) throws -> ProfileLogin {
        putCalledWith = item
        return item
    }
    
    func remove(_ item: ProfileLogin, _ completion: @escaping (ProfileLogin?) -> Void) {
        
    }
    
}

class TestLoginTokenRepository : LoginTokenRepository {
    
    var putCalledWith: LoginToken?
    
    func put(_ item: LoginToken) throws -> LoginToken {
        putCalledWith = item
        return putCalledWith!
    }
    
}

class TestRepositoryFactory : RepositoryFactory {
    
    var profileLoginRepository = TestProfileLoginRepository()
    var loginTokenRepository = TestLoginTokenRepository()
    
    func getProfileLoginRepository() -> ProfileLoginRepository {
        return profileLoginRepository
    }
    
    func getLoginTokenRepository() -> LoginTokenRepository {
        return loginTokenRepository
    }
    
    
}


import XCTest

@testable import devicecontrol_ios

class ProfileLoginServiceTests : XCTestCase {
    
//    private var loginService: LoginService? = nil

    override func setUp() {
//        let repositoryFactory = ProfileRepositoryFactory()
        let oAuthApi = AlamofireOAuthApi()
//        loginService = ProfileLoginService(repositoryFactory: repositoryFactory, oAuthApi: oAuthApi)
        clearDefaults()
    }

    override func tearDown() {
        clearDefaults()
    }
    
    func clearDefaults() {
//        let cleanExpectation = self.expectation(description: "cleanExpectation")
//        loginService?.clearLogins() { result, error in
//            cleanExpectation.fulfill()
//        }
//        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testStoresProfileLogins() {

//        let issuedAt = Int64(Date().timeIntervalSince1970)
//
//        let oAuthGrant = OAuthGrant(tokenKey: "fakeTokenKey", tokenType: "Bearer", refreshToken: "fakeRefreshToken", expiresIn: 3600, issuedAt: issuedAt)
//
//        let login = ProfileLogin(profileid: "12dj3kjs", userid: "1234567876543", host: "some.host.com", secure: false, oAuthGrant: oAuthGrant)
//
//        let login2 = ProfileLogin(profileid: "sjq63ghd", userid: "324wer4r343grg", host: "some.host.com", secure: false, oAuthGrant: oAuthGrant)
//
//        let expectation = self.expectation(description: "putLogin")
//
//        let expectation2 = self.expectation(description: "putLogin2")
//
//        loginService?.saveLogin(login) { result, error in
//            expectation.fulfill()
//        }
//
//        loginService?.saveLogin(login2) { result, error in
//            expectation2.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//
//        let expectation3 = self.expectation(description: "getAllLogins")
//
//        var logins: [ProfileLogin]?
//
//        loginService?.getAllLogins() { result, error in
//            logins = result
//            expectation3.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//
//        XCTAssert(logins?.count == 2)
        
    }
 
    func testClearsProfileLogins() {
//
//        let issuedAt = Int64(Date().timeIntervalSince1970)
//
//        let oAuthGrant = OAuthGrant(tokenKey: "fakeTokenKey", tokenType: "Bearer", refreshToken: "fakeRefreshToken", expiresIn: 3600, issuedAt: issuedAt)
//
//        let login = ProfileLogin(profileid: "12dj3kjs", userid: "1234567876543", host: "some.host.com", secure: false, oAuthGrant: oAuthGrant)
//
//        let login2 = ProfileLogin(profileid: "sjq63ghd", userid: "324wer4r343grg", host: "some.host.com", secure: false, oAuthGrant: oAuthGrant)
//
//        let expectation = self.expectation(description: "putLogin")
//
//        let expectation2 = self.expectation(description: "putLogin2")
//
//        loginService?.saveLogin(login) { result, error in
//            expectation.fulfill()
//        }
//
//        loginService?.saveLogin(login2) { result, error in
//            expectation2.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//
//        let expectation3 = self.expectation(description: "clearExpectation")
//
//        loginService?.clearLogins() { result, error in
//            expectation3.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//
//        let expectation4 = self.expectation(description: "getAllLogins")
//
//        var logins: [ProfileLogin]?
//
//        loginService?.getAllLogins() { result, error in
//            logins = result
//            expectation4.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//
//        XCTAssert(logins?.count == 0)
    }
    
    func testRemovesProfileLogin() {
//
//        let issuedAt = Int64(Date().timeIntervalSince1970)
//
//        let oAuthGrant = OAuthGrant(tokenKey: "fakeTokenKey", tokenType: "Bearer", refreshToken: "fakeRefreshToken", expiresIn: 3600, issuedAt: issuedAt)
//
//        let login = ProfileLogin(profileid: "12dj3kjs", userid: "1234567876543", host: "some.host.com", secure: false, oAuthGrant: oAuthGrant)
//
//        let expectation = self.expectation(description: "putLoginExpectation")
//
//        loginService?.saveLogin(login) { result, error in
//            expectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//
//        let expectation2 = self.expectation(description: "removeExpectation")
//
//        loginService?.removeLogin(login) { result, error in
//            if (result) {
//                expectation2.fulfill()
//            }
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//
//        let expectation3 = self.expectation(description: "getAllRemainingLogins")
//
//        var logins: [ProfileLogin]?
//
//        loginService?.getAllLogins() { result, error in
//            logins = result
//            expectation3.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//
//        XCTAssert(logins?.count == 0)
        
    }
    
    func testSettingActiveProfile() {
//
//        let issuedAt = Int64(Date().timeIntervalSince1970)
//
//        let oAuthGrant = OAuthGrant(tokenKey: "fakeTokenKey", tokenType: "Bearer", refreshToken: "fakeRefreshToken", expiresIn: 3600, issuedAt: issuedAt)
//
//        let login = ProfileLogin(profileid: "12dj3kjs", userid: "1234567876543", host: "some.host.com", secure: false, oAuthGrant: oAuthGrant)
//
//        let login2 = ProfileLogin(profileid: "sjq63ghd", userid: "324wer4r343grg", host: "some.host.com", secure: false, oAuthGrant: oAuthGrant)
//
//        let expectation = self.expectation(description: "putLogin")
//
//        let expectation2 = self.expectation(description: "putLogin2")
//
//        loginService?.saveLogin(login) { result, error in
//            expectation.fulfill()
//        }
//
//        loginService?.saveLogin(login2) { result, error in
//            expectation2.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//
//        let expectation3 = self.expectation(description: "saveActiveLogin")
//
//        loginService?.setActiveLogin(login) { result, error in
//            expectation3.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//
//        let expectation4 = self.expectation(description: "getActiveLogin")
//
//        var testLogin: ProfileLogin?
//
//        loginService?.getActiveLogin() { result, error in
//            testLogin = result
//            expectation4.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//
//        XCTAssert(testLogin?.profileid == login.profileid)
//
    }
}

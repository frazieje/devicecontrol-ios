import XCTest

@testable import devicecontrol_ios

class DefaultProfileServerMapperTests : XCTestCase {
    
    let mapper: ProfileLoginMapper = DefaultProfileLoginMapper()

    override func setUp() {

    }

    override func tearDown() {
        
    }
    
    func testHostStringConvertsToProfileServer() {
        
        let testString = "api.farsystem.net"
        
        let result = mapper.from(serverUrls: [testString])
        
        XCTAssertEqual(testString, result[0].host)
        XCTAssertEqual(80, result[0].port)
        XCTAssertEqual(false, result[0].secure)
        
    }
    
    func testHostStringWithPortConvertsToProfileServer() {
        
        let testString = "api.farsystem.net:8080"
        
        let result = mapper.from(serverUrls: [testString])
        
        XCTAssertEqual("api.farsystem.net", result[0].host)
        XCTAssertEqual(8080, result[0].port)
        XCTAssertEqual(false, result[0].secure)
        
    }
    
    func testFullUnsupportedUrlDoesNotConvertToProfileServer() {
        
        let testString = "something://api.farsystem.net:8080"
        
        let result = mapper.from(serverUrls: [testString])
        
        XCTAssertEqual("api.farsystem.net", result[0].host)
        XCTAssertEqual(8080, result[0].port)
        XCTAssertEqual(false, result[0].secure)
        
    }


}

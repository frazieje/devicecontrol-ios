import XCTest

@testable import devicecontrol_ios

class MulticastNearbyProfileScannerTests : XCTestCase {
    
    private let scanner: NearbyProfileScanner = MulticastNearbyProfileScanner()

    override func setUp() {
        
    }

    override func tearDown() {
    }
    
    func testScansUDBMulticast() {
        
        let expectation = self.expectation(description: "scanresult")
        
        var scanResults: [ServiceBeaconMessage]? = nil
        
        scanner.scan { results in
            scanResults = results
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60, handler: nil)
        
        XCTAssert(scanResults!.count > 0)
        
    }
    
}

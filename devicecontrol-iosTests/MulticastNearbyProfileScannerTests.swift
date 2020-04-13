import XCTest
import NIO

@testable import devicecontrol_ios

class MulticastNearbyProfileScannerTests : XCTestCase, ScanResultHandler {

    private let scanner = MulticastNearbyProfileScanner(groupAddress: "224.0.0.149", port: 9889)
    
    private var expectation: XCTestExpectation? = nil
    
    private var scanResults: [String : ServiceBeaconMessage]? = nil
    
    private let allocator = ByteBufferAllocator()
    
    private let expectedBeaconMessage = ServiceBeaconMessage(
        serviceName: "someService",
        profileId: "9dfhd74h",
        apiPort: 8080,
        authApiPort: 9443,
        replicationRemoteHost: "api.farsystem.net",
        replicationRemotePort: 8443)
    
    private let expectedFromAddress = "192.168.2.160"

    override func setUp() {
        
        self.expectation = expectation(description: "scanresult")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            let jsonEncoder = JSONEncoder()
            var payload: String?
            do {
                payload = try String(data: jsonEncoder.encode(self.expectedBeaconMessage), encoding: .utf8)
            } catch {
                print("error encoding beacon message into buffer \(error)")
            }
            
            let length = Int32(payload!.utf8.count)
            
            var buffer = self.allocator.buffer(capacity: Int(length + 4))
            
            buffer.writeInteger(length)
            
            buffer.writeString(payload!)
            
            self.scanner.onChannelRead(data: { buffer }, fromAddress: self.expectedFromAddress)
        }
        
        scanner.scan(self)
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    override func tearDown() {
        scanner.stop()
    }
    
    func testReportsIsScanning() {
        XCTAssert(scanner.isScanning())
    }
    
    func testScansUDPMulticast() {
        
        XCTAssert(scanResults!.count > 0)
        
    }
    
    func testFindsFromAddress() {
        
        XCTAssert(scanResults?[expectedFromAddress] != nil)
        
    }
    
    func testFindsServiceName() {
        
        XCTAssert(scanResults?[expectedFromAddress]?.serviceName == expectedBeaconMessage.serviceName)
        
    }
    
    func testFindsProfileId() {
        
        XCTAssert(scanResults?[expectedFromAddress]?.profileId == expectedBeaconMessage.profileId)
        
    }
    
    func onResult(_ result: [String : ServiceBeaconMessage]) {
        self.scanResults = result
        self.expectation?.fulfill()
    }

}

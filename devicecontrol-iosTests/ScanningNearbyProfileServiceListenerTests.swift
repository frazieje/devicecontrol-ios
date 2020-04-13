import XCTest

@testable import devicecontrol_ios

class ScanningNearbyProfileServiceListenerTests : XCTestCase {

    private var expectationOne: XCTestExpectation?
    
    private var expectationTwo: XCTestExpectation?
    
    private var fakeProfileScanner: NearbyProfileScanner?
    
    private var subscriptionOne: NearbyProfileServiceSubscription?
    private var subscriptionTwo: NearbyProfileServiceSubscription?
    
    private let expectedHost1 = "192.168.2.160"
    
    private let expectedHost2 = "192.168.3.170"
    
    private var actualResultOne: [String : [ProfileServer]]?
    private var actualResultTwo: [String : [ProfileServer]]?
    
    private let expectedBeacon1 = ServiceBeaconMessage(
        serviceName: "someService",
        profileId: "90fjh34r",
        apiPort: 8080,
        authApiPort: 9443,
        replicationRemoteHost: "api.farsystem.net",
        replicationRemotePort: 8443)
    
    private let expectedBeacon2 = ServiceBeaconMessage(
        serviceName: "someService2",
        profileId: "78gh34f6",
        apiPort: 8080,
        authApiPort: 9443,
        replicationRemoteHost: "api.farsystem.net",
        replicationRemotePort: 8443)
    
    private var expectedResult: [String : ServiceBeaconMessage]?
    
    private var nearbyProfileService: ScanningNearbyProfileService?
    
    override func setUp() {
        
        expectedResult = [expectedHost1 : expectedBeacon1, expectedHost2 : expectedBeacon2]
        
        fakeProfileScanner = FakeNearbyProfileScanner(fakeResult: expectedResult!, stopExpectation: expectation(description: "scannerStop"))

        nearbyProfileService = ScanningNearbyProfileService(scanner: fakeProfileScanner!)
        
        subscriptionOne = nearbyProfileService?.register(listenerOne(result:))
        
        subscriptionTwo = nearbyProfileService?.register(listenerTwo(result:))
        
        expectationOne = expectation(description: "scanresult1")
        
        expectationTwo = expectation(description: "scanresult2")
        
        expectationOne?.assertForOverFulfill = false
        expectationTwo?.assertForOverFulfill = false
        
        wait(for: [expectationOne!, expectationTwo!], timeout: 5)
        
        nearbyProfileService?.unregister(subscriptionOne!)
        nearbyProfileService?.unregister(subscriptionTwo!)
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    public func listenerOne(result: [String : [ProfileServer]]) -> Void {
        print("listener 1 called")
        actualResultOne = result
        expectationOne?.fulfill()
    }
    
    public func listenerTwo(result: [String : [ProfileServer]]) -> Void {
        print("listener 2 called")
        actualResultTwo = result
        expectationTwo?.fulfill()
    }
    
    func testNotifiesListeners() {
        
        XCTAssert(true)
        
    }
    
    func testResultOneProfileIdOne() {
        XCTAssert(actualResultOne?[expectedBeacon1.profileId] != nil)
    }
    
    func testResultOneProfileIdTwo() {
        XCTAssert(actualResultOne?[expectedBeacon2.profileId] != nil)
    }
    
    func testResultTwoProfileIdOne() {
        XCTAssert(actualResultTwo?[expectedBeacon1.profileId] != nil)
    }
    
    func testResultTwoProfileIdTwo() {
        XCTAssert(actualResultTwo?[expectedBeacon2.profileId] != nil)
    }
    
    func testResultOneHasProfileServers() {
        XCTAssert(actualResultOne?[expectedBeacon1.profileId]?.count == 2)
    }
    
    func testResultTwoHasProfileServers() {
        XCTAssert(actualResultTwo?[expectedBeacon2.profileId]?.count == 2)
    }
    
    func testResultOneHasProfileServerHost() {
        XCTAssert(actualResultOne?[expectedBeacon1.profileId]?.contains { $0.host == expectedHost1 } == true)
    }
    
    func testResultOneHasProfileServerRemoteHost() {
        XCTAssert(actualResultOne?[expectedBeacon1.profileId]?.contains { $0.host == expectedBeacon1.replicationRemoteHost } == true)
    }
    
    func testResultOneHasProfileServerPort() {
        XCTAssert(actualResultOne?[expectedBeacon1.profileId]?.contains { $0.port == expectedBeacon1.apiPort } == true)
    }
    
    func testResultOneHasProfileServerRemotePort() {
        XCTAssert(actualResultOne?[expectedBeacon1.profileId]?.contains { $0.port == 80 } == true)
    }
}

class FakeNearbyProfileScanner : NearbyProfileScanner {

    private let serialQueue = DispatchQueue(label: "com.spoohapps.devicecontrol.fakeNearbyProfileScanner")
    
    private var isActive: Bool = false
    
    private let fakeResult: [String : ServiceBeaconMessage]
    
    private let stopExpectation: XCTestExpectation
    
    init(fakeResult: [String : ServiceBeaconMessage], stopExpectation: XCTestExpectation) {
        self.fakeResult = fakeResult
        self.stopExpectation = stopExpectation
    }
    
    func scan(_ resultHandler: ScanResultHandler) {
        serialQueue.sync {
            isActive = true
            scheduleResult(resultHandler)
        }
    }
    
    func scheduleResult(_ resultHandler: ScanResultHandler) {
        print("scheduling result")
        serialQueue.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            if (self.isActive) {
                print("calling onResult")
                resultHandler.onResult(self.fakeResult)
                self.scheduleResult(resultHandler)
            }
        }
    }
    
    func stop() {
        print("stop called")
        serialQueue.sync {
            isActive = false
        }
        stopExpectation.fulfill()
    }
    
    func isScanning() -> Bool {
        var result = false
        serialQueue.sync {
            result = isActive
        }
        return result
    }
    
}

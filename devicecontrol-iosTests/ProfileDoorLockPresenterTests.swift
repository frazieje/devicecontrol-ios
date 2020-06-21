import XCTest

@testable import devicecontrol_ios

class ProfileDoorLockPresenterTests : XCTestCase {
    
    private var presenter: DoorLockPresenter?
    
    private var mockDeviceService = MockDeviceService()
    
    override func setUp() {
        presenter = ProfileDoorLockPresenter(router: FakeRouter(), deviceService: mockDeviceService)
    }

    override func tearDown() {
        
    }
    
    func testSendsLockMessage() {
        
        let deviceId = "\(DeviceType.door_lock.toHexString())004a6b23df12"
        
        let doorlock = DoorLock(deviceId: deviceId, name: "Some Device", description: nil, lastUpdated: Date(), lastStateChange: nil, state: DoorLock.State.unlocked)
        
        presenter?.onLock(item: doorlock)
        
        let serviceCalls = mockDeviceService.getPublishCalls()
        
        XCTAssertEqual(1, serviceCalls.count)
        
        let serviceCall = serviceCalls[0]
        
        XCTAssertEqual(deviceId, serviceCall.deviceId)
        XCTAssertEqual(DoorLock.stateTopic, serviceCall.message.topic)
        XCTAssertEqual(Data("\(DoorLock.lockCommand)".utf8), serviceCall.message.payload)
        
    }
    
    func testSendsUnlockMessage() {
        
        let deviceId = "\(DeviceType.door_lock.toHexString())004a6b23df12"
        
        let doorlock = DoorLock(deviceId: deviceId, name: "Some Device", description: nil, lastUpdated: Date(), lastStateChange: nil, state: DoorLock.State.locked)
        
        presenter?.onUnlock(item: doorlock)
        
        let serviceCalls = mockDeviceService.getPublishCalls()
        
        XCTAssertEqual(1, serviceCalls.count)
        
        let serviceCall = serviceCalls[0]
        
        XCTAssertEqual(deviceId, serviceCall.deviceId)
        XCTAssertEqual(DoorLock.stateTopic, serviceCall.message.topic)
        XCTAssertEqual(Data("\(DoorLock.unlockCommand)".utf8), serviceCall.message.payload)
        
    }
    
    func testSendsNoLockMessageWhenLocked() {
        
        let deviceId = "\(DeviceType.door_lock.toHexString())004a6b23df12"
        
        let doorlock = DoorLock(deviceId: deviceId, name: "Some Device", description: nil, lastUpdated: Date(), lastStateChange: nil, state: DoorLock.State.locked)
        
        presenter?.onLock(item: doorlock)
        
        let serviceCalls = mockDeviceService.getPublishCalls()
        
        XCTAssertEqual(0, serviceCalls.count)
        
    }
    
    func testSendsNoUnlockMessageWhenUnlocked() {
        
        let deviceId = "\(DeviceType.door_lock.toHexString())004a6b23df12"
        
        let doorlock = DoorLock(deviceId: deviceId, name: "Some Device", description: nil, lastUpdated: Date(), lastStateChange: nil, state: DoorLock.State.unlocked)
        
        presenter?.onUnlock(item: doorlock)
        
        let serviceCalls = mockDeviceService.getPublishCalls()
        
        XCTAssertEqual(0, serviceCalls.count)
        
    }
    
}

import XCTest

@testable import devicecontrol_ios

class SerializationTetsts: XCTestCase {
    
    let encoder: JSONEncoder = JSONEncoder()
    let decoder: JSONDecoder = JSONDecoder()
    
    override func setUp() {
        encoder.dateEncodingStrategy = .millisecondsSince1970
        decoder.dateDecodingStrategy = .millisecondsSince1970
    }

    override func tearDown() {
        
    }

    func testMessagesSerializeCorrectly() {
        
        let expectedString = "{\"topic\":\"testTopic\",\"payload\":\"Mw==\",\"headers\":{\"x-device\":true}}"
        let message = Message(topic: "testTopic", payload: Data(base64Encoded: "Mw=="), headers: [
            "x-device": true
        ])
        
        let result = try? encoder.encode(message)
        
        let resultString = String(data: result!, encoding: .utf8)
        
        XCTAssertEqual(expectedString, resultString)
        
    }
    
    func testMessageDeserializesCorrectly() {
        let expectedString = "{\"topic\":\"testTopic\",\"payload\":\"Mw==\",\"headers\":{\"x-device\":true,\"x-other\":\"string\",\"x-hops\":1}}"
        let message = Message(topic: "testTopic", payload: Data(base64Encoded: "Mw=="), headers: [
            "x-hops": 1,
            "x-device": true,
            "x-other": "string"
        ])
        let decoded = try? decoder.decode(Message.self, from: expectedString.data(using: .utf8)!)
        XCTAssertEqual(decoded!.topic, "testTopic")
        XCTAssertEqual(decoded!.payload, message.payload)
        XCTAssertEqual(decoded!.headers, message.headers)
    }
    
    func testCachedDevicesDeserializeCorrectly() {
        let date = Date()
        let jsonString = "{\"cachedDate\":\(date.timeIntervalSince1970 * 1000),\"cachedMessageList\":[],\"type\":\"door_lock\",\"address\":{\"data\":\"AKpUj\\/2p\"}}"
        let decoded = try? decoder.decode(CachedDevice.self, from: jsonString.data(using: .utf8)!)
        XCTAssertEqual(decoded!.cachedDate.timeIntervalSince1970, date.timeIntervalSince1970)
        XCTAssertEqual(decoded!.cachedMessageList.count, 0)
        XCTAssertEqual(decoded!.type, .door_lock)
        XCTAssertEqual(decoded!.address, EUI48Address(data: Data(base64Encoded: "AKpUj/2p")!))
    }
    
    func testDeviceTypeSerialization() {
        let date = Date()
        let cachedDevice = CachedDevice(type: .door_lock, address: EUI48Address(data: Data(base64Encoded: "AKpUj/2p")!), cachedDate: date, cachedMessageList: [])
        let result = try? encoder.encode(cachedDevice)
        let resultString = String(data: result!, encoding: .utf8)
        XCTAssertEqual(resultString, "{\"cachedDate\":\(date.timeIntervalSince1970 * 1000),\"cachedMessageList\":[],\"type\":\"door_lock\",\"address\":{\"data\":\"AKpUj\\/2p\"}}")
    }

}

import XCTest

@testable import devicecontrol_ios

class SerializationTetsts: XCTestCase {
    
    let encoder: JSONEncoder = JSONEncoder()
    let decoder: JSONDecoder = JSONDecoder()
    
    override func setUp() {

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
        let jsonString = "\"door_lock\""
        let decoded = try? decoder.decode(DeviceType.self, from: jsonString.data(using: .utf8)!)
        XCTAssertEqual(decoded!, .door_lock)
    }

}

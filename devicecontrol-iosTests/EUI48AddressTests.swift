//
//  EUI48AddressTests.swift
//  devicecontrol-iosTests
//
//  Created by Joel Frazier on 10/27/19.
//  Copyright © 2019 Spoohapps, Inc. All rights reserved.
//

import XCTest

@testable import devicecontrol_ios

class EUI48AddressTests: XCTestCase {
    
    override func setUp() {

    }

    override func tearDown() {
        
    }
    
    func testAsString() {
        let address = EUI48Address(data: Data(base64Encoded: "AKpUj/2p")!, name: nil, address: nil)
        XCTAssertEqual(address.asString(), "00aa548afda9")
    }
    
}

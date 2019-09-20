//
//  StdlibExtensionTests.swift
//  UserDefaultsGeneratorCoreTests
//
//  Created by Yudai Hirose on 2019/09/21.
//

import XCTest
@testable import UserDefaultsGeneratorCore

class StdlibExtensionTests: XCTestCase {

    func testCollectionGrouped() {
        let configurations = [SwiftType.any, .bool, .bool].map { Configuration(name: $0.rawValue, type: $0, key: nil) }
        let result = configurations.grouped { $0.type }
        
        XCTAssertEqual(result[.any]?.count, 1)
        XCTAssertEqual(result[.bool]?.count, 2)
    }
    
    func testDictionaryOrdered() {
        let result = ["a": 1, "c": 2, "b": 3].ordered()
        XCTAssertEqual(result[0].key, "a")
        XCTAssertEqual(result[1].key, "b")
        XCTAssertEqual(result[2].key, "c")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

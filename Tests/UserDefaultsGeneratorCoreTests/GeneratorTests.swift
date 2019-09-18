//
//  GeneratorTests.swift
//  UserDefaultsGeneratorTests
//
//  Created by Yudai Hirose on 2019/09/19.
//

import XCTest
@testable import UserDefaultsGeneratorCore

class GeneratorTests: XCTestCase {


    func testEnumDefinition() {
        XCTContext.runActivity(named: "When key is nil") { (_) in
            let configurations: [Configuration] = [
                Configuration(name: "enumKey", type: .Int, key: nil),
            ]
            let got = enumDefinition(configurations: configurations)
            let expected = """
public enum UDGIntKey: String {
\(tab)case enumKey
}
"""
            XCTAssertEqual(got, expected)
        }
        XCTContext.runActivity(named: "When configuration for custom key") { (_) in
            let configurations: [Configuration] = [
                Configuration(name: "enumKey", type: .Bool, key: "Custom"),
            ]
            let got = enumDefinition(configurations: configurations)
            let expected = """
            public enum UDGBoolKey: String {
            \(tab)case enumKey = "Custom"
            }
            """
            XCTAssertEqual(got, expected)
        }
    }
    
    func testUserDefaultsExtensions() {
        XCTContext.runActivity(named: "When swift type is Int") { (_) in
            let configurations: [Configuration] = [
                Configuration(name: "enumKey", type: .Int, key: nil),
            ]
            let got = userDefaultsExtensions(configurations: configurations)
            let expected = """
            extension UserDefaults {
            \(tab)public func integer(forKey key: UDGIntKey) -> Int {
            \(tab)\(tab)return integer(forKey: key.rawValue)
            \(tab)}
            \(tab)public func set(_ value: Int, forKey key: UDGIntKey) {
            \(tab)\(tab)set(value, forKey: key.rawValue)
            \(tab)\(tab)synchronize()
            \(tab)}
            }
            """
            XCTAssertEqual(got, expected)
        }
        XCTContext.runActivity(named: "When swift type is Bool") { (_) in
            let configurations: [Configuration] = [
                Configuration(name: "enumKey", type: .Bool, key: "Custom"),
            ]
            let got = userDefaultsExtensions(configurations: configurations)
            let expected = """
            extension UserDefaults {
            \(tab)public func bool(forKey key: UDGBoolKey) -> Bool {
            \(tab)\(tab)return bool(forKey: key.rawValue)
            \(tab)}
            \(tab)public func set(_ value: Bool, forKey key: UDGBoolKey) {
            \(tab)\(tab)set(value, forKey: key.rawValue)
            \(tab)\(tab)synchronize()
            \(tab)}
            }
            """
            XCTAssertEqual(got, expected)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

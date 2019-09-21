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
                Configuration(name: "enumKey", type: .int, key: nil),
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
                Configuration(name: "enumKey", type: .bool, key: "Custom"),
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
                Configuration(name: "enumKey", type: .int, key: nil),
            ]
            let got = userDefaultsExtensions(configurations: configurations)
            let expected = """

            // MARK: - UserDefaults Int Extension
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
        XCTContext.runActivity(named: "When swift type is Bool. And add custom enum key name") { (_) in
            let configurations: [Configuration] = [
                Configuration(name: "enumKey", type: .bool, key: "Custom"),
            ]
            let got = userDefaultsExtensions(configurations: configurations)
            let expected = """
            
            // MARK: - UserDefaults Bool Extension
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
        XCTContext.runActivity(named: "When swift type is Any. Any is optional type") { (_) in
            let configurations: [Configuration] = [
                Configuration(name: "enumKey", type: .any, key: nil),
            ]
            let got = userDefaultsExtensions(configurations: configurations)
            let expected = """
            
            // MARK: - UserDefaults Any Extension
            extension UserDefaults {
            \(tab)public func object(forKey key: UDGAnyKey) -> Any? {
            \(tab)\(tab)return object(forKey: key.rawValue)
            \(tab)}
            \(tab)public func set(_ value: Any?, forKey key: UDGAnyKey) {
            \(tab)\(tab)set(value, forKey: key.rawValue)
            \(tab)\(tab)synchronize()
            \(tab)}
            }
            
            """
            XCTAssertEqual(got, expected)
        }
        XCTContext.runActivity(named: "When swift type is Array. Array return type name is [Any]") { (_) in
            let configurations: [Configuration] = [
                Configuration(name: "enumKey", type: .array, key: nil),
            ]
            let got = userDefaultsExtensions(configurations: configurations)
            let expected = """
            
            // MARK: - UserDefaults Array Extension
            extension UserDefaults {
            \(tab)public func array(forKey key: UDGArrayKey) -> [Any]? {
            \(tab)\(tab)return array(forKey: key.rawValue)
            \(tab)}
            \(tab)public func set(_ value: [Any]?, forKey key: UDGArrayKey) {
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

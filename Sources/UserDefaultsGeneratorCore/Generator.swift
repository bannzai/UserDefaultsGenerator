//
//  Generator.swift
//  CYaml
//
//  Created by Yudai Hirose on 2019/09/18.
//

import Foundation

public protocol Generator {
    func generate() throws
}

public struct GeneratorImpl: Generator {
    let configurations: [Configuration]
    let outputPath: URL
    public init(configurations: [Configuration], outputPath: URL) {
        self.configurations = configurations
        self.outputPath = outputPath
    }
    public func generate() throws {
        let content = enumDefinition() + "\n" + userDefaultsExtensions()
        try content.write(to: outputPath, atomically: true, encoding: .utf8)
    }
    
    func enumDefinition() -> String {
        return configurations
            .grouped { $0.type }
            .map { grouped in
                let values = grouped.value.map { "case " + $0.name }.joined(separator: "\n")
                return """
                public enum UDG\(grouped.key.rawValue)Key: String {
                \(values)
                }
                """
            }
            .joined(separator: "\n")
    }
    
    func userDefaultsExtensions() -> String {
        return configurations
            .grouped { $0.type }
            .map { grouped in
                let key = grouped.key
                return """
                extension UserDefaults {
                    public func \(key.rawValue)(forKey key: UDG\(key.rawValue)Key) -> \(key.rawValue) {
                        return \(key.getterMethodName)(forKey: key.rawValue)
                    }
                    public func set(_ value: \(key.rawValue), forKey key: UDG\(key.rawValue)Key) {
                        set(value, forKey: key.rawValue)
                        synchronize()
                    }
                }
                """
            }
            .joined(separator: "\n")
    }
}

extension Array {
    func grouped<T: Comparable>(_ closure: (Element) -> (T)) -> [T: [Element]] {
         return reduce(into: [T: [Element]]()){ result, element in
            let key = closure(element)
            switch result[key] {
            case nil:
                result[key] = [element]
            case let a?:
                result[key] = a + [element]
            }
        }
    }
}
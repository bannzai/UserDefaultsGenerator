//
//  Generator.swift
//  CYaml
//
//  Created by Yudai Hirose on 2019/09/18.
//

import Foundation

let tab = "\t"
public protocol Generator {
    func generate(configurations: [Configuration]) throws
}

public struct GeneratorImpl: Generator {
    let outputPath: URL
    public init(configurations: [Configuration], outputPath: URL) {
        self.outputPath = outputPath
    }
    public func generate(configurations: [Configuration]) throws {
        let content = enumDefinition(configurations: configurations) + "\n" + userDefaultsExtensions(configurations: configurations)
        try content.write(to: outputPath, atomically: true, encoding: .utf8)
    }
    
}

func enumDefinition(configurations: [Configuration]) -> String {
    let caseMap: (Configuration) -> String = { configuration in
        switch configuration.key {
        case nil:
            return "case " + configuration.name
        case let key?:
            return "case " + configuration.name + " = " + "\"\(key)\""
        }
    }
    return configurations
        .grouped { $0.type }
        .map { grouped in
            let values = grouped.value.map(caseMap).joined(separator: "\n")
            return """
            public enum UDG\(grouped.key.rawValue)Key: String {
            \(tab)\(values)
            }
            """
        }
        .joined(separator: "\n")
}

func userDefaultsExtensions(configurations: [Configuration]) -> String {
    return configurations
        .grouped { $0.type }
        .map { grouped in
            let key = grouped.key
            return """
            extension UserDefaults {
            \(tab)public func \(key.getterMethodName)(forKey key: UDG\(key.rawValue)Key) -> \(key.rawValue) {
            \(tab)\(tab)return \(key.getterMethodName)(forKey: key.rawValue)
            \(tab)}
            \(tab)public func set(_ value: \(key.rawValue), forKey key: UDG\(key.rawValue)Key) {
            \(tab)\(tab)set(value, forKey: key.rawValue)
            \(tab)\(tab)synchronize()
            \(tab)}
            }
            """
        }
        .joined(separator: "\n")
}

extension Array {
    func grouped<T: Hashable>(_ closure: (Element) -> (T)) -> [T: [Element]] {
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

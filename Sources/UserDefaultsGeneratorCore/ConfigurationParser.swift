import Foundation
import Yams

public enum SwiftType: String, Decodable, Comparable {
    public static func < (lhs: SwiftType, rhs: SwiftType) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    case Int
    case Bool
    
    var getterMethodName: String {
        switch self {
        case .Int:
            return "integer"
        case .Bool:
            return "bool"
        }
    }
}

public struct Configuration: Decodable {
    public let name: String
    public let type: SwiftType
    public let key: String?
}

public protocol ConfigurationParser {
    func parse() throws -> [Configuration]
}

public struct YamlParser: ConfigurationParser {
    let yamlFilePath: URL
    public init(yamlFilePath: URL) {
        self.yamlFilePath = yamlFilePath
    }
    func read() throws -> String {
        return try String(contentsOf: yamlFilePath)
    }
    public func parse() throws -> [Configuration] {
        let decoder = YAMLDecoder()
        let decoded = try decoder.decode([Configuration].self, from: try read())
        return decoded
    }
}

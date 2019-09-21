import Foundation
import Yams

public struct Configuration: Decodable {
    public let name: String
    public let type: SwiftType
    public let key: String?
}

public protocol ConfigurationParser {
    func parse(yamlFilePath: URL) throws -> [Configuration]
}

public struct YAMLParser: ConfigurationParser {
    public init() { }
    func read(yamlFilePath: URL) throws -> String {
        return try String(contentsOf: yamlFilePath)
    }
    public func parse(yamlFilePath: URL) throws -> [Configuration] {
        let decoder = YAMLDecoder()
        let decoded = try decoder.decode([Configuration].self, from: try read(yamlFilePath: yamlFilePath))
        return decoded
    }
}

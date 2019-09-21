//
//  Generator.swift
//  CYaml
//
//  Created by Yudai Hirose on 2019/09/18.
//

import Foundation
import StencilSwiftKit

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
        let content = """
        import Foundation
        \(enumDefinition(configurations: configurations))
        \(userDefaultsExtensions(configurations: configurations))
        """
        try content.write(to: outputPath, atomically: true, encoding: .utf8)
    }
    
}

private func buildArguments(_ configurations: [Configuration]) -> [String: Any] {
    let groupedConfigurations = configurations.grouped { $0.type }.ordered()
    return [
        "groupedConfigurations": groupedConfigurations
            .map { (key, configurations) -> [String: Any] in
                return [
                    "key": key,
                    "typeName": key.typeName,
                    "getterMethodName": key.getterMethodName,
                    "configurations": configurations
                        .map { configuration -> [String: Any] in
                            return [
                                    "name": configuration.name,
                                    "key": configuration.key ?? ""
                                ]
                            
                    }
                ]
                
        }
        
    ]
}

func enumDefinition(configurations: [Configuration]) -> String {
    return try! StencilSwiftTemplate(
        templateString: TemplateType.enum.template,
        environment: stencilSwiftEnvironment(),
        name: "enum.swift.stencil"
        )
        .render(buildArguments(configurations))
}

func userDefaultsExtensions(configurations: [Configuration]) -> String {
    return try! StencilSwiftTemplate(
        templateString: TemplateType.extension.template,
        environment: stencilSwiftEnvironment(),
        name: "extension.swift.stencil"
        )
        .render(buildArguments(configurations))
}

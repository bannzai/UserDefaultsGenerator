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
    func generate(outputPath: URL, templatePath: URL?, configurations: [Configuration]) throws
}

public struct GeneratorImpl: Generator {
    public init(){ }
    public func generate(outputPath: URL, templatePath: URL?, configurations: [Configuration]) throws {
        let content: String
        switch templatePath {
        case nil:
            content = """
            import Foundation
            \(enumDefinition(configurations: configurations))
            \(userDefaultsExtensions(configurations: configurations))
            """
        case let templatePath?:
            let template = try String(contentsOf: templatePath)
            content = try StencilSwiftTemplate(
                templateString: template,
                environment: stencilSwiftEnvironment(),
                name: "udg.user_defined.swift.stencil"
                )
                .render(buildArguments(configurations))
        }
        try content.write(to: outputPath, atomically: true, encoding: .utf8)
    }
    
}

private func buildArguments(_ configurations: [Configuration]) -> [String: Any] {
    let groupedConfigurations = configurations.grouped { $0.type }.ordered()
    return [
        "groupedConfigurations": groupedConfigurations
            .map { (swiftType, configurations) -> [String: Any] in
                return [
                    "key": swiftType,
                    "typeName": swiftType.typeName,
                    "aliasName": swiftType.aliasName,
                    "isOptionalType": swiftType.isOptional,
                    "getterMethodName": swiftType.getterMethodName,
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

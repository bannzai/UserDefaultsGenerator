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
        let content = enumDefinition(configurations: configurations) + "\n" + userDefaultsExtensions(configurations: configurations)
        try content.write(to: outputPath, atomically: true, encoding: .utf8)
    }
    
}

private func buildArguments(_ configurations: [Configuration]) -> [String: Any] {
    return [
        "groupedConfigurations": configurations.grouped { $0.type }.ordered()
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

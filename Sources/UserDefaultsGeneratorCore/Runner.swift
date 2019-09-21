//
//  Runner.swift
//  CYaml
//
//  Created by Yudai Hirose on 2019/09/21.
//

import Foundation

public protocol Runner {
    static var commandName: String { get }
    init()
    func run() throws
}

public struct GenerateRunner: Runner {
    public static let commandName: String = "generate"
    
    // TODO: Use Opaque Result Type
    private let argumentParser: GenerateRunnerArgumentParser
    private let configurationParser: ConfigurationParser
    private let generator: Generator
    public init(
        argumentParser: GenerateRunnerArgumentParser,
        configurationParser: ConfigurationParser,
        generator: Generator
        ) {
        self.argumentParser = argumentParser
        self.configurationParser = configurationParser
        self.generator = generator
    }
    
    public init() {
        self.init(argumentParser: GenerateRunnerArgumentParser(), configurationParser: YAMLParser(), generator: GeneratorImpl())
    }
    
    public func run() throws {
        let options = argumentParser.parse()
        let configurations = try configurationParser.parse(yamlFilePath: options.configPath)
        try generator.generate(outputPath: options.outputURL, configurations: configurations)
    }
}

public struct SetupRunner: Runner  {
    public static let commandName: String = "setup"
    
    public init() { }
    public func run() throws {
        let content = """
- name: numberOfIndent
type: Int

- name: UserSelectedDarkMode
type: Bool
key: DarkMode
"""
        try content.write(to: URL(fileURLWithPath: currentWorkingDirectory()), atomically: true, encoding: .utf8)
    }
}

public struct HelpRunner: Runner  {
    public static let commandName: String = "help"
    
    public static func help() -> String {
        return """
Usage:
  udg [command]

Available Commands:
  generate    generate [--output $OUTPUT_PATH] [--config $CONFIG_PATH] [--template $TEMPLATE_PATH]
  setup       setup can be generated example config file
  help        Help about any command
"""
    }
    
    public init() { }
    public func run() throws {
        print(HelpRunner.help())
    }
}

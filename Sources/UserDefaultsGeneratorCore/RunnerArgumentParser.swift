//
//  RunnerArgumentParser.swift
//  CYaml
//
//  Created by Yudai Hirose on 2019/09/21.
//

import Foundation

public typealias RunnerArguments = [String]

public protocol RunnerArgumentParser {
    associatedtype Argument
    func parse() -> Argument
}


func currentWorkingDirectory() -> String {
    switch ProcessInfo.processInfo.environment["YMD_DEBUG_CWD"] {
    case nil:
        return FileManager.default.currentDirectoryPath
    case let cwd?:
        return cwd
    }
}

public struct GenerateRunnerArgumentParser: RunnerArgumentParser {
    enum Option: String, CaseIterable {
        case output
        case config
        case template
        
        var option: String {
            return "--\(rawValue)"
        }
        
        init?(option: String) {
            switch Option.allCases.first(where: { $0.option == option }) {
            case nil:
                return nil
            case let option?:
                self = option
            }
        }
    }
    
    public init() { }
    
    public func parse() -> (outputURL: URL, configPath: URL, templatePath: URL?) {
        let arguments = ProcessInfo.processInfo.arguments
        let options = arguments
            .enumerated()
            .filter { Option.allCases.map { $0.option }.contains($1) }
            .map { (offset: $0, option: Option(option: $1)!) }
            .map { (offset: $0, option: $1, value: arguments[$0 + 1]) }
        
        let cwd = URL(fileURLWithPath: currentWorkingDirectory())
        
        let outputURL: URL
        if let option = options.first (where: { $0.option == .output }) {
            outputURL = cwd.appendingPathComponent(option.value)
        } else {
            let swiftFileName = "UserDefaultsGenerator.generated.swift"
            outputURL = cwd.appendingPathComponent(swiftFileName)
        }
        
        let configPath: URL
        if let option = options.first(where: { $0.option == .config }) {
            configPath = cwd.appendingPathComponent(option.value)
        } else {
            let yamlFileName = "udg.yml"
            configPath = cwd.appendingPathComponent(yamlFileName)
        }
        
        var templatePath: URL? = nil
        if let option = options.first(where: { $0.option == .template }) {
            templatePath = cwd.appendingPathComponent(option.value)
        }

        return (outputURL: outputURL, configPath: configPath, templatePath: templatePath)
    }
}

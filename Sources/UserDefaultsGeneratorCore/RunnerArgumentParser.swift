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
    }
    
    public func parse() -> (outputURL: URL, configPath: URL, templatePath: URL?) {
        let arguments = ProcessInfo.processInfo.arguments
        let options = arguments
            .enumerated()
            .filter { Option.allCases.map { $0.option }.contains($1) }
            .map { (offset: $0, option: Option(rawValue: $1)!) }
            .map { (offset: $0, option: $1, value: arguments[$0 + 1]) }
        
        let outputURL: URL
        if let option = options.first (where: { $0.option == .output }) {
            outputURL = URL(fileURLWithPath: option.value)
        } else {
            let swiftFileName = "UserDefaultsGenerator.generated.swift"
            outputURL = URL(fileURLWithPath: currentWorkingDirectory()).appendingPathComponent(swiftFileName)
        }
        
        let configPath: URL
        if let option = options.first(where: { $0.option == .config }) {
            configPath = URL(fileURLWithPath: option.value)
        } else {
            let yamlFileName = "udg.yml"
            configPath = URL(fileURLWithPath: currentWorkingDirectory()).appendingPathComponent(yamlFileName)
        }
        
        var templatePath: URL? = nil
        if let option = options.first(where: { $0.option == .template }) {
            templatePath = URL(fileURLWithPath: option.value)
        }

        return (outputURL: outputURL, configPath: configPath, templatePath: templatePath)
    }
}

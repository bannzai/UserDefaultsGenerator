//
//  Runner.swift
//  CYaml
//
//  Created by Yudai Hirose on 2019/09/21.
//

import Foundation

public typealias RunnerArguments = [String]

public protocol Runner {
    static var commandName: String { get }
    func run(arguments: RunnerArguments) throws
}

public struct GenerateRunner: Runner  {
    public static let commandName: String = "generate"
    public func run(arguments: RunnerArguments) throws {
        
    }
}

public struct SetupRunner: Runner  {
    public static let commandName: String = "setup"
    public func run(arguments: RunnerArguments) throws {

    }
}

import Foundation
import UserDefaultsGeneratorCore

let path: String

switch ProcessInfo.processInfo.environment["YMD_DEBUG_CWD"] {
case nil:
    path = FileManager.default.currentDirectoryPath
case let cwd?:
    path = cwd
}
let yamlFileName = "udg.yml"
let url = URL(fileURLWithPath: path + "/" + yamlFileName)
let parser = YAMLParser(yamlFilePath: url)
do {
    let configurations = try parser.parse()
    print(configurations)
    let swiftFileName = "UserDefaultsGenerator.generated.swift"
    let generator = GeneratorImpl(
        configurations: configurations,
        outputPath: URL(fileURLWithPath: path + "/" + swiftFileName)
    )
    try generator.generate()
} catch {
    print(error.localizedDescription)
    exit(1)
}



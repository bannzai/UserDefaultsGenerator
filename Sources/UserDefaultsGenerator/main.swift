import Foundation
import UserDefaultsGeneratorCore

let arguments = ProcessInfo.processInfo.arguments
if arguments.count <= 1, arguments[1] != "help" {
    print("""
        Missing argument.
        See below
        \(HelpRunner.help())
""")
    exit(1)
}
let subCommand = ProcessInfo.processInfo.arguments[1]

let runners: [Runner.Type] = [
    GenerateRunner.self,
    SetupRunner.self,
    HelpRunner.self
]

guard let command = runners.first(where: { $0.commandName == subCommand }) else {
    print("""
        Unexpected sub command \(subCommand)
        See below
        \(HelpRunner.help())
        """)
    exit(1)
}

try command.init().run()

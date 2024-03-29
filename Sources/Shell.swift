import Foundation

public struct Shell {
    public static func execute(command: String, arguments: [String]? = nil, executionPath: String = ".") -> String {
        let process = Process()
        process.launchPath = command
        process.currentDirectoryPath = executionPath
        process.arguments = arguments

        let pipe = Pipe()
        process.standardOutput = pipe
        process.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()

        guard let output: String = String(data: data, encoding: String.Encoding.utf8) else {
            return ""
        }

        return output
    }
}

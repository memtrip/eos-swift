import Foundation

public struct ChainErrorDetail : Decodable {
    public let message: String
    public let file: String
    public let line_number: Int
    public let method: String

    public init(message: String, file: String, line_number: Int, method: String) {
        self.message = message
        self.file = file
        self.line_number = line_number
        self.method = method
    }
}

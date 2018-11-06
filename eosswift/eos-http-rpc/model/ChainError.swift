import Foundation

public struct ChainError : Decodable {
    public let code: Int
    public let message: String
    public let error: ChainErrorItem

    public init(code: Int, message: String, error: ChainErrorItem) {
        self.code = code
        self.message = message
        self.error = error
    }
}

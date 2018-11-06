import Foundation

public struct ChainErrorItem : Decodable {
    public let code: Int
    public let name: String
    public let what: String
    public let details: [ChainErrorDetail]

    public init(code: Int, name: String, what: String, details: [ChainErrorDetail]) {
        self.code = code
        self.name = name
        self.what = what
        self.details = details
    }
}

import Foundation

public struct AbiBinToJson : Codable {
    public let code: String
    public let action: String
    public let binargs: String

    public init(code: String, action: String, binargs: String) {
        self.code = code
        self.action = action
        self.binargs = binargs
    }
}

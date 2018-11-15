import Foundation

public struct AbiField : Decodable {
    public let name: String
    public let type: String

    public init(name: String, type: String) {
        self.name = name
        self.type = type
    }
}

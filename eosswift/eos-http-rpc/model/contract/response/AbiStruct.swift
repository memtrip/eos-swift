import Foundation

public struct AbiStruct : Codable {
    public let name: String
    public let base: String
    public let fields: Array<AbiField>

    public init(name: String, base: String, fields: Array<AbiField>) {
        self.name = name
        self.base = base
        self.fields = fields
    }
}

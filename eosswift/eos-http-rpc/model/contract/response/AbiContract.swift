import Foundation

public struct AbiContract : Decodable {
    public let version: String
    public let types: Array<AbiType>
    public let structs: Array<AbiStruct>
    public let actions: Array<AbiAction>
    public let tables: Array<AbiTable>

    public init(version: String, types: Array<AbiType>, structs: Array<AbiStruct>, actions: Array<AbiAction>, tables: Array<AbiTable>) {
        self.version = version
        self.types = types
        self.structs = structs
        self.actions = actions
        self.tables = tables
    }
}

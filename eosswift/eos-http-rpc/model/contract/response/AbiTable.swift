import Foundation

public struct AbiTable : Decodable {
    public let name: String
    public let index_type: String
    public let key_names: Array<String>
    public let key_types: Array<String>
    public let type: String

    public init(name: String, index_type: String, key_names: Array<String>, key_types: Array<String>, type: String) {
        self.name = name
        self.index_type = index_type
        self.key_names = key_names
        self.key_types = key_types
        self.type = type
    }
}

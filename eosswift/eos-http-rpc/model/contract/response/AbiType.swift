import Foundation

public struct AbiType : Decodable {
    public let new_type_name: String
    public let type: String

    public init(new_type_name: String, type: String) {
        self.new_type_name = new_type_name
        self.type = type
    }
}

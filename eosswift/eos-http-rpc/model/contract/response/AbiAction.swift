import Foundation

public struct AbiAction : Decodable {
    public let name: String
    public let type: String
    public let ricardian_contract: String

    public init(name: String, type: String, ricardian_contract: String) {
        self.name = name
        self.type = type
        self.ricardian_contract = ricardian_contract
    }
}

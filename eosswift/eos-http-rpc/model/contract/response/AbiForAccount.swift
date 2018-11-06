import Foundation

public struct AbiForAccount : Codable {
    public let account_name: String
    public let abi: AbiContract

    public init(account_name: String, abi: AbiContract) {
        self.account_name = account_name
        self.abi = abi
    }
}

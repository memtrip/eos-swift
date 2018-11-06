import Foundation

public struct TransactionAct : Codable {
    public let account: String
    public let name: String
    public let authorization: Array<TransactionAuthorization>
    public let hex_data: String?

    public init(account: String, name: String, authorization: Array<TransactionAuthorization>, hex_data: String?) {
        self.account = account
        self.name = name
        self.authorization = authorization
        self.hex_data = hex_data
    }
}

import Foundation

public struct TransactionAct : Decodable {
    public let account: String
    public let name: String
    public let authorization: Array<TransactionActAuthorization>
    public let hex_data: String?
    public let data: [String: AnyJSONType]

    public init(account: String, name: String, authorization: Array<TransactionActAuthorization>, hex_data: String?, data: [String: AnyJSONType]) {
        self.account = account
        self.name = name
        self.authorization = authorization
        self.hex_data = hex_data
        self.data = data
    }
}

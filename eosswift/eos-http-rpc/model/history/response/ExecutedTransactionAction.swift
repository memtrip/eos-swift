import Foundation

public struct ExecutedTransactionAction : Decodable {
    public let account: String
    public let name: String
    public let authorization: Array<TransactionActAuthorization>
    public let data: String?

    public init(account: String, name: String, authorization: Array<TransactionActAuthorization>, data: String?) {
        self.account = account
        self.name = name
        self.authorization = authorization
        self.data = data
    }
}

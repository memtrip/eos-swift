import Foundation

public struct Action : Encodable {
    public let account: String
    public let name: String
    public let authorization: Array<TransactionAuthorization>
    public let data: String?

    public init(account: String, name: String, authorization: Array<TransactionAuthorization>, data: String?) {
        self.account = account
        self.name = name
        self.authorization = authorization
        self.data = data
    }
}

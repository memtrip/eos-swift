import Foundation

public struct ActionAbi : Encodable {
    public let account: AccountNameWriterValue
    public let name: AccountNameWriterValue
    public let authorization: [TransactionAuthorizationAbi]
    public let data: DataWriterValue

    public init(account: AccountNameWriterValue, name: AccountNameWriterValue, authorization: [TransactionAuthorizationAbi], data: DataWriterValue) {
        self.account = account
        self.name = name
        self.authorization = authorization
        self.data = data
    }
}

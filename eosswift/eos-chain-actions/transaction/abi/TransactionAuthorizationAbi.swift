import Foundation

public struct TransactionAuthorizationAbi : Encodable {
    public let actor: AccountNameWriterValue
    public let permission: AccountNameWriterValue

    public init(actor: AccountNameWriterValue, permission: AccountNameWriterValue) {
        self.actor = actor
        self.permission = permission
    }
}

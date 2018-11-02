import Foundation

struct TransactionAuthorizationAbi : Encodable {
    let actor: AccountNameWriterValue
    let permission: AccountNameWriterValue
}

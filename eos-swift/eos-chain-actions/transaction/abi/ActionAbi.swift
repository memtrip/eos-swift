import Foundation

struct ActionAbi : Encodable {
    let account: AccountNameWriterValue
    let name: AccountNameWriterValue
    let authorization: [TransactionAuthorizationAbi]
    let data: DataWriterValue
}

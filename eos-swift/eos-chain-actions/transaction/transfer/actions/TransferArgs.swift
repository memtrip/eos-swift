import Foundation

struct TransferArgs : Encodable {
    let fromValue: AccountNameWriterValue
    let to: AccountNameWriterValue
    let quantity: AssetWriterValue
    let memo: String
}

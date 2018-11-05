import Foundation

struct TransferArgs : Encodable {
    let from: AccountNameWriterValue
    let to: AccountNameWriterValue
    let quantity: AssetWriterValue
    let memo: String
}

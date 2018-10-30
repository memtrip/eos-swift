import Foundation

struct BuyRamBytesArgs : Encodable {
    let payer: AccountNameWriterValue
    let receiver: AccountNameWriterValue
    let bytes: Int64
}

import Foundation

struct BuyRamArgs : Encodable {
    let payer: AccountNameWriterValue
    let receiver: AccountNameWriterValue
    let quant: AssetWriterValue
}

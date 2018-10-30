import Foundation

struct SellRamArgs : Encodable {
    let account: AccountNameWriterValue
    let bytes: Int64
}

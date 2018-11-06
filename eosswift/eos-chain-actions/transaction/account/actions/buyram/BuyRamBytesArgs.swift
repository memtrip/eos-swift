import Foundation

public struct BuyRamBytesArgs : Encodable {
    let payer: AccountNameWriterValue
    let receiver: AccountNameWriterValue
    let bytes: Int64

    public init(payer: AccountNameWriterValue, receiver: AccountNameWriterValue, bytes: Int64) {
        self.payer = payer
        self.receiver = receiver
        self.bytes = bytes
    }
}

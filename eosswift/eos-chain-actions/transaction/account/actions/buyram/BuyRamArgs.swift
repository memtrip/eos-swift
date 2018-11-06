import Foundation

public struct BuyRamArgs : Encodable {
    public let payer: AccountNameWriterValue
    public let receiver: AccountNameWriterValue
    public let quant: AssetWriterValue

    public init(payer: AccountNameWriterValue, receiver: AccountNameWriterValue, quant: AssetWriterValue) {
        self.payer = payer
        self.receiver = receiver
        self.quant = quant
    }
}

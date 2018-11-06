import Foundation

public struct TransferArgs : Encodable {
    public let from: AccountNameWriterValue
    public let to: AccountNameWriterValue
    public let quantity: AssetWriterValue
    public let memo: String

    public init(from: AccountNameWriterValue, to: AccountNameWriterValue, quantity: AssetWriterValue, memo: String) {
        self.from = from
        self.to = to
        self.quantity = quantity
        self.memo = memo
    }
}

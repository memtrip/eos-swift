import Foundation

public struct ExecutedTransactionParent : Decodable {
    public let receipt: ExecutedTransactionReceipt
    public let trx: ExecutedTransaction

    public init(receipt: ExecutedTransactionReceipt, trx: ExecutedTransaction) {
        self.receipt = receipt
        self.trx = trx
    }
}

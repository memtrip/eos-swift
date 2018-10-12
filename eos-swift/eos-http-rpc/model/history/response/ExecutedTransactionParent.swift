import Foundation

struct ExecutedTransactionParent : Codable {
    let receipt: ExecutedTransactionReceipt
    let trx: ExecutedTransaction
}

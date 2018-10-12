import Foundation

struct TransactionCommitted : Codable {
    let transaction_id: String
    let processed: TransactionProcessed
}

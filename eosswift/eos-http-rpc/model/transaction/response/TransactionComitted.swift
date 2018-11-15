import Foundation

public struct TransactionCommitted : Decodable {
    public let transaction_id: String
    public let processed: TransactionProcessed

    public init(transaction_id: String, processed: TransactionProcessed) {
        self.transaction_id = transaction_id
        self.processed = processed
    }
}

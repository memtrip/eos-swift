import Foundation

struct TransactionProcessed : Codable {
    let id: String
    let receipt: TransactionParentReceipt
    let elapsed: Int
    let net_usage: Int
    let scheduled: Bool
    let action_traces: Array<TransactionActionTrace>
}

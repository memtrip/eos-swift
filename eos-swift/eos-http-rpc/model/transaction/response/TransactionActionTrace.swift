import Foundation

struct TransactionActionTrace : Codable {
    let receipt: TransactionReceipt
    let act: TransactionAct
    let elapsed: Int
    let cpu_usage: Int
    let console: String
    let total_cpu_usage: Int
    let trx_id: String
    let inline_traces: Array<TransactionActionTrace>
}

import Foundation

struct HistoricAccountAction : Codable {
    let global_action_seq: Int
    let account_action_seq: Int
    let block_num: Int
    let block_time: Date
    let action_trace: TransactionActionTrace
}

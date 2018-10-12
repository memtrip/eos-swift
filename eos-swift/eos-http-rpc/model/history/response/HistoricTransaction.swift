import Foundation

struct HistoricTransaction : Codable {
    let id: String
    let trx: ExecutedTransactionParent
    let block_time: Date
    let block_num: Int
    let last_irreversible_block: Int
    let traces: Array<TransactionActionTrace>
}

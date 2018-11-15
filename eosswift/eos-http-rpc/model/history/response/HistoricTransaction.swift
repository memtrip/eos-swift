import Foundation

public struct HistoricTransaction : Decodable {
    public let id: String
    public let trx: ExecutedTransactionParent
    public let block_time: Date
    public let block_num: Int
    public let last_irreversible_block: Int
    public let traces: Array<TransactionActionTrace>

    public init(id: String, trx: ExecutedTransactionParent, block_time: Date, block_num: Int, last_irreversible_block: Int, traces: Array<TransactionActionTrace>) {
        self.id = id
        self.trx = trx
        self.block_time = block_time
        self.block_num = block_num
        self.last_irreversible_block = last_irreversible_block
        self.traces = traces
    }
}

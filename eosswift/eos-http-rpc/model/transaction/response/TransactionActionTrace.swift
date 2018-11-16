import Foundation

public struct TransactionActionTrace : Decodable {
    public let receipt: TransactionReceipt
    public let act: TransactionAct
    public let elapsed: Int
    public let cpu_usage: Int?
    public let console: String
    public let total_cpu_usage: Int?
    public let trx_id: String
    public let inline_traces: Array<TransactionActionTrace>

    public init(receipt: TransactionReceipt, act: TransactionAct, elapsed: Int, cpu_usage: Int, console: String, total_cpu_usage: Int, trx_id: String, inline_traces: Array<TransactionActionTrace>) {
        self.receipt = receipt
        self.act = act
        self.elapsed = elapsed
        self.cpu_usage = cpu_usage
        self.console = console
        self.total_cpu_usage = total_cpu_usage
        self.trx_id = trx_id
        self.inline_traces = inline_traces
    }
}

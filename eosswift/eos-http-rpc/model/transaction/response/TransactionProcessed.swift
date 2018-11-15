import Foundation

public struct TransactionProcessed : Decodable {
    public let id: String
    public let receipt: TransactionParentReceipt
    public let elapsed: Int
    public let net_usage: Int
    public let scheduled: Bool
    public let action_traces: Array<TransactionActionTrace>

    public init(id: String, receipt: TransactionParentReceipt, elapsed: Int, net_usage: Int, scheduled: Bool, action_traces: Array<TransactionActionTrace>) {
        self.id = id
        self.receipt = receipt
        self.elapsed = elapsed
        self.net_usage = net_usage
        self.scheduled = scheduled
        self.action_traces = action_traces
    }
}

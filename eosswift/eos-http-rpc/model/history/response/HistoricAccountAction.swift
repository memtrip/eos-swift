import Foundation

public struct HistoricAccountAction : Decodable {
    public let global_action_seq: Int
    public let account_action_seq: Int
    public let block_num: Int
    public let block_time: Date
    public let action_trace: TransactionActionTrace

    public init(global_action_seq: Int, account_action_seq: Int, block_num: Int, block_time: Date, action_trace: TransactionActionTrace) {
        self.global_action_seq = global_action_seq
        self.account_action_seq = account_action_seq
        self.block_num = block_num
        self.block_time = block_time
        self.action_trace = action_trace
    }
}

import Foundation

public struct ExecutedTransaction : Codable {
    let expiration: Date
    let ref_block_num: Int
    let ref_block_prefix: UInt64
    let max_net_usage_words: UInt64
    let max_cpu_usage_ms: UInt64
    let delay_sec: UInt64
    let context_free_actions: Array<Action>
    let transaction_extensions: Array<String>
    let signatures: Array<String>
    let context_free_data: Array<String>

    public init(expiration: Date, ref_block_num: Int, ref_block_prefix: UInt64, max_net_usage_words: UInt64, max_cpu_usage_ms: UInt64, delay_sec: UInt64, context_free_actions: Array<Action>, transaction_extensions: Array<String>, signatures: Array<String>, context_free_data: Array<String>) {
        self.expiration = expiration
        self.ref_block_num = ref_block_num
        self.ref_block_prefix = ref_block_prefix
        self.max_net_usage_words = max_net_usage_words
        self.max_cpu_usage_ms = max_cpu_usage_ms
        self.delay_sec = delay_sec
        self.context_free_actions = context_free_actions
        self.transaction_extensions = transaction_extensions
        self.signatures = signatures
        self.context_free_data = context_free_data
    }
}

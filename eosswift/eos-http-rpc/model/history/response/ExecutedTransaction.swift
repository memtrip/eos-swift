import Foundation

public struct ExecutedTransaction : Decodable {
    let expiration: Date
    let ref_block_num: SafeInt64
    let ref_block_prefix: SafeInt64
    let max_net_usage_words: SafeInt64
    let max_cpu_usage_ms: SafeInt64
    let delay_sec: SafeInt64
    let context_free_actions: Array<ExecutedTransactionAction>
    let transaction_extensions: Array<String>
    let signatures: Array<String>
    let context_free_data: Array<String>

    public init(expiration: Date, ref_block_num: SafeInt64, ref_block_prefix: SafeInt64, max_net_usage_words: SafeInt64, max_cpu_usage_ms: SafeInt64, delay_sec: SafeInt64, context_free_actions: Array<ExecutedTransactionAction>, transaction_extensions: Array<String>, signatures: Array<String>, context_free_data: Array<String>) {
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

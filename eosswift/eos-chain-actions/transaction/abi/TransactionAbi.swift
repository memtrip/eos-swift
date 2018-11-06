import Foundation

public struct TransactionAbi : Encodable {
    public let expiration: TimestampWriterValue
    public let ref_block_num: BlockNumWriterValue
    public let ref_block_prefix: BlockPrefixWriterValue
    public let max_net_usage_words: UInt64
    public let max_cpu_usage_ms: UInt64
    public let delay_sec: UInt64
    public let context_free_actions: [ActionAbi]
    public let actions: [ActionAbi]
    public let transaction_extensions: StringCollectionWriterValue

    public init(expiration: TimestampWriterValue, ref_block_num: BlockNumWriterValue, ref_block_prefix: BlockPrefixWriterValue, max_net_usage_words: UInt64, max_cpu_usage_ms: UInt64, delay_sec: UInt64, context_free_actions: [ActionAbi], actions: [ActionAbi], transaction_extensions: StringCollectionWriterValue) {
        self.expiration = expiration
        self.ref_block_num = ref_block_num
        self.ref_block_prefix = ref_block_prefix
        self.max_net_usage_words = max_net_usage_words
        self.max_cpu_usage_ms = max_cpu_usage_ms
        self.delay_sec = delay_sec
        self.context_free_actions = context_free_actions
        self.actions = actions
        self.transaction_extensions = transaction_extensions
    }
}

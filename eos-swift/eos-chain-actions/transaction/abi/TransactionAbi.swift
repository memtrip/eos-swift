import Foundation

struct TransactionAbi : Encodable {
    let expiration: TimestampWriterValue
    let ref_block_num: BlockNumWriterValue
    let ref_block_prefix: BlockPrefixWriterValue
    let max_net_usage_words: UInt64
    let max_cpu_usage_ms: UInt64
    let delay_sec: UInt64
    let context_free_actions: [ActionAbi]
    let actions: [ActionAbi]
    let transaction_extensions: StringCollectionWriterValue
    let signatures: StringCollectionWriterValue
    let context_free_data: StringCollectionWriterValue
}

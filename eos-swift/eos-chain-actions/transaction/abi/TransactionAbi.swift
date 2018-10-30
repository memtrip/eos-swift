import Foundation

struct TransactionAbi : Codable {
    let expiration: Date
    let ref_block_num: Int
    let ref_block_prefix: Int64
    let max_net_usage_words: Int64
    let max_cpu_usage_ms: Int64
    let delay_sec: Int64
    let context_free_actions: [ActionAbi]
    let actions: [ActionAbi]
    let transaction_extensions: [String]
    let context_free_data: [String]
}

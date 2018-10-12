import Foundation

struct Transaction : Codable {
    let expiration: Date
    let ref_block_num: Int
    let ref_block_prefix: UInt64
    let max_net_usage_words: UInt64
    let max_cpu_usage_ms: UInt64
    let delay_sec: UInt64
    let context_free_actions: Array<Action>
    let actions: Array<Action>
    let transaction_extensions: Array<String>
    let signatures: Array<String>
    let context_free_data: Array<String>
}

import Foundation

struct ExecutedTransactionReceipt : Codable {
    let status: String
    let cpu_usage_us: Int
    let net_usage_words: Int
}

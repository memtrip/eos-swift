import Foundation

struct CycleSummaryTransaction : Codable {
    let id: String
    let status: String
    let kcpu_usage: Int
    let net_usage_words: Int
}

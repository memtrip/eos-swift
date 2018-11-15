import Foundation

public struct TransactionParentReceipt : Decodable {
    public let status: String
    public let cpu_usage_us: Int
    public let net_usage_words: Int

    public init(status: String, cpu_usage_us: Int, net_usage_words: Int) {
        self.status = status
        self.cpu_usage_us = cpu_usage_us
        self.net_usage_words = net_usage_words
    }
}

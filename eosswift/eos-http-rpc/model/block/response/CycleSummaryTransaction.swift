import Foundation

public struct CycleSummaryTransaction : Decodable {
    public let id: String
    public let status: String
    public let kcpu_usage: Int
    public let net_usage_words: Int

    public init(id: String, status: String, kcpu_usage: Int, net_usage_words: Int) {
        self.id = id
        self.status = status
        self.kcpu_usage = kcpu_usage
        self.net_usage_words = net_usage_words
    }
}

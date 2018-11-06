import Foundation

public struct CycleSummary : Codable {
    public let transactions: Array<CycleSummaryTransaction>

    public init(transactions: Array<CycleSummaryTransaction>) {
        self.transactions = transactions
    }
}

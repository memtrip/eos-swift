import Foundation

public struct CycleSummary : Decodable {
    public let transactions: Array<CycleSummaryTransaction>

    public init(transactions: Array<CycleSummaryTransaction>) {
        self.transactions = transactions
    }
}

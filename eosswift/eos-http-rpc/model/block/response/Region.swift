import Foundation

public struct Region : Decodable {
    public let region: Int
    public let cycles_summary: Array<CycleSummary>

    public init(region: Int, cycles_summary: Array<CycleSummary>) {
        self.region = region
        self.cycles_summary = cycles_summary
    }
}

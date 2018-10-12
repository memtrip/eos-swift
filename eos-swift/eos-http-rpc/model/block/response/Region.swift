import Foundation

struct Region : Codable {
    let region: Int
    let cycles_summary: Array<CycleSummary>
}

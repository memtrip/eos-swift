import Foundation

struct HistoricAccountActionParent : Codable {
    let actions: Array<HistoricAccountAction>
    let last_irreversible_block: Int
}

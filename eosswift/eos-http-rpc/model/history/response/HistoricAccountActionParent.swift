import Foundation

public struct HistoricAccountActionParent : Decodable {
    public let actions: Array<HistoricAccountAction>
    public let last_irreversible_block: Int

    public init(actions: Array<HistoricAccountAction>, last_irreversible_block: Int) {
        self.actions = actions
        self.last_irreversible_block = last_irreversible_block
    }
}

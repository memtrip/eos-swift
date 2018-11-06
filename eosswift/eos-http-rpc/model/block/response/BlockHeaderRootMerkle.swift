import Foundation

public struct BlockHeaderRootMerkle : Codable {
    public let _active_nodes: Array<String>
    public let _node_count: Int

    public init(_active_nodes: Array<String>, _node_count: Int) {
        self._active_nodes = _active_nodes
        self._node_count = _node_count
    }
}

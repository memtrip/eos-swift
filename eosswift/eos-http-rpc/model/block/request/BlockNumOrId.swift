import Foundation

public struct BlockNumOrId : Encodable {
    public let block_num_or_id: String

    public init(block_num_or_id: String) {
        self.block_num_or_id = block_num_or_id
    }
}

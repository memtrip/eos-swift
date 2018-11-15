import Foundation

public struct Info : Decodable {
    public let server_version: String
    public let chain_id: String
    public let head_block_num: Int
    public let last_irreversible_block_num: Int
    public let head_block_id: String
    public let head_block_time: String
    public let head_block_producer: String

    public init(server_version: String, chain_id: String, head_block_num: Int, last_irreversible_block_num: Int, head_block_id: String, head_block_time: String, head_block_producer: String) {
        self.server_version = server_version
        self.chain_id = chain_id
        self.head_block_num = head_block_num
        self.last_irreversible_block_num = last_irreversible_block_num
        self.head_block_id = head_block_id
        self.head_block_time = head_block_time
        self.head_block_producer = head_block_producer
    }
}

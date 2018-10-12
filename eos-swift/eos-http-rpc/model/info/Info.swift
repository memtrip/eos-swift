import Foundation

struct Info : Codable {
    let server_version: String
    let chain_id: String
    let head_block_num: Int
    let last_irreversible_block_num: Int
    let head_block_id: String
    let head_block_time: String
    let head_block_producer: String
}

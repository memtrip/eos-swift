import Foundation

struct Block : Codable {
    let id: String
    let block_num: Int
    let ref_block_prefix: UInt64
    let previous: String
    let timestamp: Date
    let transaction_mroot: String
    let action_mroot: String
    let block_mroot: String?
    let producer: String
    let schedule_version: Int
    let producer_signature: String
    let regions: Array<Region>?
}

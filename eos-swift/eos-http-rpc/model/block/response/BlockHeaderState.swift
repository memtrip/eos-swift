import Foundation

struct BlockHeaderState : Codable {
    let id: String
    let block_num: Int
    let header: BlockHeaderStateHeader
    let dpos_proposed_irreversible_blocknum: Int
    let dpos_irreversible_blocknum: Int
    let bft_irreversible_blocknum: Int
    let pending_schedule_lib_num: Int
    let pending_schedule_hash: String
    let pending_schedule: BlockHeaderSchedule
    let active_schedule: BlockHeaderSchedule
    let blockroot_merkle: BlockHeaderRootMerkle
    let block_signing_key: String
}

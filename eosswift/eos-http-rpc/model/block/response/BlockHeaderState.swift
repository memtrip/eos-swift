import Foundation

public struct BlockHeaderState : Decodable {
    public let id: String
    public let block_num: Int
    public let header: BlockHeaderStateHeader
    public let dpos_proposed_irreversible_blocknum: Int
    public let dpos_irreversible_blocknum: Int
    public let bft_irreversible_blocknum: Int
    public let pending_schedule_lib_num: Int
    public let pending_schedule_hash: String
    public let pending_schedule: BlockHeaderSchedule
    public let active_schedule: BlockHeaderSchedule
    public let blockroot_merkle: BlockHeaderRootMerkle
    public let block_signing_key: String

    public init(id: String, block_num: Int, header: BlockHeaderStateHeader, dpos_proposed_irreversible_blocknum: Int, dpos_irreversible_blocknum: Int, bft_irreversible_blocknum: Int, pending_schedule_lib_num: Int, pending_schedule_hash: String, pending_schedule: BlockHeaderSchedule, active_schedule: BlockHeaderSchedule, blockroot_merkle: BlockHeaderRootMerkle, block_signing_key: String) {
        self.id = id
        self.block_num = block_num
        self.header = header
        self.dpos_proposed_irreversible_blocknum = dpos_proposed_irreversible_blocknum
        self.dpos_irreversible_blocknum = dpos_irreversible_blocknum
        self.bft_irreversible_blocknum = bft_irreversible_blocknum
        self.pending_schedule_lib_num = pending_schedule_lib_num
        self.pending_schedule_hash = pending_schedule_hash
        self.pending_schedule = pending_schedule
        self.active_schedule = active_schedule
        self.blockroot_merkle = blockroot_merkle
        self.block_signing_key = block_signing_key
    }
}

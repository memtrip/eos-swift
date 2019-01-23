import Foundation

public struct Block : Decodable {
    public let id: String
    public let block_num: SafeInt64
    public let ref_block_prefix: SafeInt64
    public let previous: String
    public let timestamp: Date
    public let transaction_mroot: String
    public let action_mroot: String
    public let block_mroot: String?
    public let producer: String
    public let schedule_version: Int
    public let producer_signature: String
    public let regions: Array<Region>?

    public init(id: String, block_num: SafeInt64, ref_block_prefix: SafeInt64, previous: String, timestamp: Date, transaction_mroot: String, action_mroot: String, block_mroot: String?, producer: String, schedule_version: Int, producer_signature: String, regions: Array<Region>?) {
        self.id = id
        self.block_num = block_num
        self.ref_block_prefix = ref_block_prefix
        self.previous = previous
        self.timestamp = timestamp
        self.transaction_mroot = transaction_mroot
        self.action_mroot = action_mroot
        self.block_mroot = block_mroot
        self.producer = producer
        self.schedule_version = schedule_version
        self.producer_signature = producer_signature
        self.regions = regions
    }
}

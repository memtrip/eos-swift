import Foundation

struct BlockHeaderSchedule : Codable {
    let version: Int
    let producers: Array<BlockHeaderProducer>
}

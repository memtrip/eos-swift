import Foundation

public struct BlockHeaderSchedule : Codable {
    public let version: Int
    public let producers: Array<BlockHeaderProducer>

    public init(version: Int, producers: Array<BlockHeaderProducer>) {
        self.version = version
        self.producers = producers
    }
}

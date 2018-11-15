import Foundation

public struct BlockHeaderProducer : Decodable {
    public let producer_name: String
    public let block_signing_key: String

    public init(producer_name: String, block_signing_key: String) {
        self.producer_name = producer_name
        self.block_signing_key = block_signing_key
    }
}

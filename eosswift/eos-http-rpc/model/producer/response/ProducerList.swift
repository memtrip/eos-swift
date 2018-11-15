import Foundation

public struct ProducerList : Decodable {
    public let rows: Array<Producer>
    public let total_producer_vote_weight: String
    public let more: String

    public init(rows: Array<Producer>, total_producer_vote_weight: String, more: String) {
        self.rows = rows
        self.total_producer_vote_weight = total_producer_vote_weight
        self.more = more
    }
}

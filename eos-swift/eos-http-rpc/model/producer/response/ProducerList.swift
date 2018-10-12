import Foundation

struct ProducerList : Codable {
    let rows: Array<Producer>
    let total_producer_vote_weight: String
    let more: String
}

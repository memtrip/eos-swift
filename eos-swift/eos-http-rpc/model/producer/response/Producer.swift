import Foundation

struct Producer : Codable {
    let owner: String
    let total_votes: String
    let producer_key: String
    let is_active: Int
    let url: String
    let unpaid_blocks: Int
    let last_claim_time: String
    let location: Int
}

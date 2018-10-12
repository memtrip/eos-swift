import Foundation

struct VoterInfo : Codable {
    let owner: String
    let proxy: String
    let producers: Array<String>
    let staked: Double
    let last_vote_weight: Double
    let proxied_vote_weight: Double
    let is_proxy: Int
}

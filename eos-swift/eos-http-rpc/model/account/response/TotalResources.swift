import Foundation

struct TotalResources : Codable {
    let owner: String
    let net_weight: String
    let cpu_weight: String
    let ram_bytes: UInt64
}

import Foundation

struct GetProducers : Codable {
    let json: Bool
    let lower_bound: String
    let limit: Int
}

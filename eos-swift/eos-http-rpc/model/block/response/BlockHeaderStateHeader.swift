import Foundation

struct BlockHeaderStateHeader : Codable {
    let timestamp: Date
    let producer: String
    let confirmed: Int
    let previous: String
    let transaction_mroot: String
    let action_mroot: String
    let schedule_version: Int
    let producer_signature: String
}

import Foundation

struct GetTableRows : Codable {
    let scope: String
    let code: String
    let table: String
    let table_key: String
    let json: Bool
    let limit: Int
    let lower_bound: String
    let upper_bound: String
    let key_type: String
    let index_position: String
    let encode_type: String
}

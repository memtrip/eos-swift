import Foundation

struct AbiTable : Codable {
    let name: String
    let index_type: String
    let key_names: Array<String>
    let key_types: Array<String>
    let type: String
}

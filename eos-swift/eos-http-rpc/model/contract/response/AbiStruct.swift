import Foundation

struct AbiStruct : Codable {
    let name: String
    let base: String
    let fields: Array<AbiField>
}

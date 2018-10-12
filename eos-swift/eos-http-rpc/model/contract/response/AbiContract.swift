import Foundation

struct AbiContract : Codable {
    let version: String
    let types: Array<AbiType>
    let structs: Array<AbiStruct>
    let actions: Array<AbiAction>
    let tables: Array<AbiTable>
}

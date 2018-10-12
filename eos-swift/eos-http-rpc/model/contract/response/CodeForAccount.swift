import Foundation

struct CodeForAccount : Codable {
    let account_name: String
    let code_hash: String
    let wast: String
    let wasm: String
}

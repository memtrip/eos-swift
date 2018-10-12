import Foundation

struct RawCodeForAccount : Codable {
    let account_name: String
    let wasm: String
    let abi: String
}

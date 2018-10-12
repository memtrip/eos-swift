import Foundation

struct GetCodeByAccountName : Codable {
    let account_name: String
    let code_as_wasm: Bool
}

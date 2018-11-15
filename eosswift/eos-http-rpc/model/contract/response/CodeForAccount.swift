import Foundation

public struct CodeForAccount : Decodable {
    public let account_name: String
    public let code_hash: String
    public let wast: String
    public let wasm: String

    public init(account_name: String, code_hash: String, wast: String, wasm: String) {
        self.account_name = account_name
        self.code_hash = code_hash
        self.wast = wast
        self.wasm = wasm
    }
}

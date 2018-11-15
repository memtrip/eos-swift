import Foundation

public struct GetCodeByAccountName : Encodable {
    public let account_name: String
    public let code_as_wasm: Bool

    public init(account_name: String, code_as_wasm: Bool) {
        self.account_name = account_name
        self.code_as_wasm = code_as_wasm
    }
}

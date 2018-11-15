import Foundation

public struct RawCodeForAccount : Decodable {
    public let account_name: String
    public let wasm: String?
    public let abi: String?

    public init(account_name: String, wasm: String?, abi: String?) {
        self.account_name = account_name
        self.wasm = wasm
        self.abi = abi
    }
}

import Foundation

public struct GetCurrencyBalance : Encodable {
    public let code: String
    public let account: String
    public let symbol: String?

    public init(code: String, account: String, symbol: String?) {
        self.code = code
        self.account = account
        self.symbol = symbol
    }
}

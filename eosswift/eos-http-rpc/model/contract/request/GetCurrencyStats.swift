import Foundation

public struct GetCurrencyStats : Encodable {
    public let code: String
    public let symbol: String

    public init(code: String, symbol: String) {
        self.code = code
        self.symbol = symbol
    }
}

import Foundation

struct GetCurrencyBalance : Codable {
    let code: String
    let account: String
    let symbol: String?
}

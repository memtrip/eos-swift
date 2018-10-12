import Foundation

struct AccountRequiredAuth : Codable {
    let threshold: Int
    let keys: Array<AccountKey>
    let accounts: Array<String>
    let waits: Array<String>
}

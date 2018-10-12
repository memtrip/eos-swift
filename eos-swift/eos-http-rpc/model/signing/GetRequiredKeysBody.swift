import Foundation

struct GetRequiredKeysBody : Codable {
    let transaction: Transaction
    let available_keys: Array<String>
}

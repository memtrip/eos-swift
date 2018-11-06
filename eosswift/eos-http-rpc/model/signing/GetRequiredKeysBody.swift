import Foundation

public struct GetRequiredKeysBody : Codable {
    public let transaction: Transaction
    public let available_keys: Array<String>

    public init(transaction: Transaction, available_keys: Array<String>) {
        self.transaction = transaction
        self.available_keys = available_keys
    }
}

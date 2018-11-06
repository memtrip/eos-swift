import Foundation

public struct AccountRequiredAuth : Codable {
    public let threshold: Int
    public let keys: Array<AccountKey>
    public let accounts: Array<String>
    public let waits: Array<String>

    public init(threshold: Int, keys: Array<AccountKey>, accounts: Array<String>, waits: Array<String>) {
        self.threshold = threshold
        self.keys = keys
        self.accounts = accounts
        self.waits = waits
    }
}

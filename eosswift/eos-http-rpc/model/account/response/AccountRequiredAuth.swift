import Foundation

public struct AccountRequiredAuth : Decodable {
    public let threshold: Int
    public let keys: Array<AccountKey>
    public let accounts: Array<AccountAuth>
    public let waits: Array<AccountAuthWait>

    public init(threshold: Int, keys: Array<AccountKey>, accounts: Array<AccountAuth>, waits: Array<AccountAuthWait>) {
        self.threshold = threshold
        self.keys = keys
        self.accounts = accounts
        self.waits = waits
    }
}

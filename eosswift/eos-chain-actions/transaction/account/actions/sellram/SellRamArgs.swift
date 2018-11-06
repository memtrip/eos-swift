import Foundation

public struct SellRamArgs : Encodable {
    public let account: AccountNameWriterValue
    public let bytes: Int64

    public init(account: AccountNameWriterValue, bytes: Int64) {
        self.account = account
        self.bytes = bytes
    }
}

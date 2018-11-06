import Foundation

public struct AccountRequiredAuthAbi : Encodable {
    public let threshold: Int32
    public let keys: [AccountKeyAbi]
    public let accounts: StringCollectionWriterValue
    public let waits: StringCollectionWriterValue

    public init(threshold: Int32, keys: [AccountKeyAbi], accounts: StringCollectionWriterValue, waits: StringCollectionWriterValue) {
        self.threshold = threshold
        self.keys = keys
        self.accounts = accounts
        self.waits = waits
    }
}

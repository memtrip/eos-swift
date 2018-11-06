import Foundation

public struct VoteArgs : Encodable {
    public let voter: AccountNameWriterValue
    public let proxy: AccountNameWriterValue
    public let producers: AccountNameCollectionWriterValue

    public init(voter: AccountNameWriterValue, proxy: AccountNameWriterValue, producers: AccountNameCollectionWriterValue) {
        self.voter = voter
        self.proxy = proxy
        self.producers = producers
    }
}

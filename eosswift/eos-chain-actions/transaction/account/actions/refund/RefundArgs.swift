import Foundation

public struct RefundArgs : Encodable {
    public let owner: AccountNameWriterValue

    public init(owner: AccountNameWriterValue) {
        self.owner = owner
    }
}

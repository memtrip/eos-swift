import Foundation

public struct NewAccountArgs : Encodable {
    public let creator: AccountNameWriterValue
    public let name: AccountNameWriterValue
    public let owner: AccountRequiredAuthAbi
    public let active: AccountRequiredAuthAbi

    public init(creator: AccountNameWriterValue, name: AccountNameWriterValue, owner: AccountRequiredAuthAbi, active: AccountRequiredAuthAbi) {
        self.creator = creator
        self.name = name
        self.owner = owner
        self.active = active
    }
}

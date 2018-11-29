import Foundation

public struct GetActions : Encodable {
    public let account_name: String
    public let pos: Int64?
    public let offset: Int64?

    public init(account_name: String, pos: Int64?, offset: Int64?) {
        self.account_name = account_name
        self.pos = pos
        self.offset = offset
    }
}

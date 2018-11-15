import Foundation

public struct GetActions : Encodable {
    public let account_name: String
    public let pos: Int?
    public let offset: Int?

    public init(account_name: String, pos: Int?, offset: Int?) {
        self.account_name = account_name
        self.pos = pos
        self.offset = offset
    }
}

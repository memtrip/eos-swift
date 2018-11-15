import Foundation

public struct AccountName : Encodable {
    public let account_name: String

    public init(account_name: String) {
        self.account_name = account_name
    }
}

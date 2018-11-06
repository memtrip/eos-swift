import Foundation

public struct AccountName : Codable {
    public let account_name: String

    public init(account_name: String) {
        self.account_name = account_name
    }
}

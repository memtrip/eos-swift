import Foundation

public struct Accounts : Decodable {
    public let account_names: Array<String>

    public init(account_names: Array<String>) {
        self.account_names = account_names
    }
}

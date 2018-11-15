import Foundation

public struct GetControlledAccounts : Encodable {
    public let controlling_account: String

    public init(controlling_account: String) {
        self.controlling_account = controlling_account
    }
}

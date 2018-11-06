import Foundation

public struct GetKeyAccounts : Encodable {
    public let public_key: String

    public init(public_key: String) {
        self.public_key = public_key
    }
}

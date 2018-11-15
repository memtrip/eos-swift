import Foundation

public struct TransactionContext {
    public let authorizingAccountName: String
    public let authorizingPrivateKey: EOSPrivateKey
    public let expirationDate: Date

    public init(authorizingAccountName: String, authorizingPrivateKey: EOSPrivateKey, expirationDate: Date) {
        self.authorizingAccountName = authorizingAccountName
        self.authorizingPrivateKey = authorizingPrivateKey
        self.expirationDate = expirationDate
    }
}

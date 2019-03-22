import Foundation

public struct TransactionContext {
    public let authorizingAccountName: String
    public let authorizingPrivateKey: EOSPrivateKey
    public let expirationDate: Date
    public let abiEncoder: () -> AbiEncoder

    public init(
        authorizingAccountName: String,
        authorizingPrivateKey: EOSPrivateKey,
        expirationDate: Date,
        abiEncoder: @escaping () -> AbiEncoder = {
            return AbiEncoder(capacity: 512)
        }
    ) {
        self.authorizingAccountName = authorizingAccountName
        self.authorizingPrivateKey = authorizingPrivateKey
        self.expirationDate = expirationDate
        self.abiEncoder = abiEncoder
    }
}

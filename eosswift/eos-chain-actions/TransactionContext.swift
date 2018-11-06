import Foundation

public struct TransactionContext {
    let authorizingAccountName: String
    let authorizingPrivateKey: EOSPrivateKey
    let expirationDate: Date
}

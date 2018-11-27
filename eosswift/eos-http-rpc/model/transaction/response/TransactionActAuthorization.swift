import Foundation

public struct TransactionActAuthorization : Codable {
    public let actor: String
    public let permission: String

    public init(actor: String, permission: String) {
        self.actor = actor
        self.permission = permission
    }
}

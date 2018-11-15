import Foundation

public struct AccountPermission : Decodable {
    public let perm_name: String
    public let parent: String
    public let required_auth: AccountRequiredAuth

    public init(perm_name: String, parent: String, required_auth: AccountRequiredAuth) {
        self.perm_name = perm_name
        self.parent = parent
        self.required_auth = required_auth
    }
}

import Foundation

struct AccountPermission : Codable {
    let perm_name: String
    let parent: String
    let required_auth: AccountRequiredAuth
}

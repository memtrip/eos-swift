import Foundation

struct GetActions : Codable {
    let account_name: String
    let pos: Int? = nil
    let offset: Int? = nil
}

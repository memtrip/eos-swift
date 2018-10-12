import Foundation

struct Action : Codable {
    let account: String
    let name: String
    let authorization: Array<TransactionAuthorization>
    let data: String?
}

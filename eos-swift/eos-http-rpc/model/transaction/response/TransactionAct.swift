import Foundation

struct TransactionAct : Codable {
    let account: String
    let name: String
    let authorization: Array<TransactionAuthorization>
    let hex_data: String?
}

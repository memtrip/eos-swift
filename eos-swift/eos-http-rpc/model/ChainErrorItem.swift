import Foundation

struct ChainErrorItem : Decodable {
    let code: Int
    let name: String
    let what: String
    let details: [ChainErrorDetail]
}

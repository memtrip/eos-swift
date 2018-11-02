import Foundation

struct ChainErrorDetail : Decodable {
    let message: String
    let file: String
    let line_number: Int
    let method: String
}

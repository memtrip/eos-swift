import Foundation

struct ChainError : Decodable {
    let code: Int
    let message: String
    let error: ChainErrorItem
}

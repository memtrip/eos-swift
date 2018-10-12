import Foundation

struct AbiForAccount : Codable {
    let account_name: String
    let abi: AbiContract
}

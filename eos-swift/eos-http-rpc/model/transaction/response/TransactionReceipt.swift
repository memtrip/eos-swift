import Foundation

struct TransactionReceipt : Codable {
    let receiver: String
    let act_digest: String
    let global_sequence: Int
    let recv_sequence: Int
    let code_sequence: Int
    let abi_sequence: Int
}

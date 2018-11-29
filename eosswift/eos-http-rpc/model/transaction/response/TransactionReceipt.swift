import Foundation

public struct TransactionReceipt : Decodable {
    public let receiver: String
    public let act_digest: String
    public let global_sequence: Int64
    public let recv_sequence: Int64
    public let code_sequence: Int64
    public let abi_sequence: Int64

    public init(receiver: String, act_digest: String, global_sequence: Int64, recv_sequence: Int64, code_sequence: Int64, abi_sequence: Int64) {
        self.receiver = receiver
        self.act_digest = act_digest
        self.global_sequence = global_sequence
        self.recv_sequence = recv_sequence
        self.code_sequence = code_sequence
        self.abi_sequence = abi_sequence
    }
}

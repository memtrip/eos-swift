import Foundation

public struct TransactionReceipt : Decodable {
    public let receiver: String
    public let act_digest: String
    public let global_sequence: SafeInt64
    public let recv_sequence: SafeInt64
    public let code_sequence: SafeInt64
    public let abi_sequence: SafeInt64

    public init(receiver: String, act_digest: String, global_sequence: SafeInt64, recv_sequence: SafeInt64, code_sequence: SafeInt64, abi_sequence: SafeInt64) {
        self.receiver = receiver
        self.act_digest = act_digest
        self.global_sequence = global_sequence
        self.recv_sequence = recv_sequence
        self.code_sequence = code_sequence
        self.abi_sequence = abi_sequence
    }
}

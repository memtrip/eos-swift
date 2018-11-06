import Foundation

public struct TransactionReceipt : Codable {
    public let receiver: String
    public let act_digest: String
    public let global_sequence: Int
    public let recv_sequence: Int
    public let code_sequence: Int
    public let abi_sequence: Int

    public init(receiver: String, act_digest: String, global_sequence: Int, recv_sequence: Int, code_sequence: Int, abi_sequence: Int) {
        self.receiver = receiver
        self.act_digest = act_digest
        self.global_sequence = global_sequence
        self.recv_sequence = recv_sequence
        self.code_sequence = code_sequence
        self.abi_sequence = abi_sequence
    }
}

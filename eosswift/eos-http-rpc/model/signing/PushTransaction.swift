import Foundation

public struct PushTransaction : Encodable {
    public let signatures: Array<String>
    public let compression: String
    public let packed_context_free_data: String
    public let packed_trx: String

    public init(signatures: Array<String>, compression: String, packed_context_free_data: String, packed_trx: String) {
        self.signatures = signatures
        self.compression = compression
        self.packed_context_free_data = packed_context_free_data
        self.packed_trx = packed_trx
    }
}

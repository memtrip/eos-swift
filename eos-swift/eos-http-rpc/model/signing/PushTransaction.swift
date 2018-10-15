import Foundation

struct PushTransaction : Encodable {
    let signatures: Array<String>
    let compression: String
    let packed_context_free_data: String
    let packed_trx: String
}

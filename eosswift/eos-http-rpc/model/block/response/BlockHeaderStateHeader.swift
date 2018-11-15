import Foundation

public struct BlockHeaderStateHeader : Decodable {
    public let timestamp: Date
    public let producer: String
    public let confirmed: Int
    public let previous: String
    public let transaction_mroot: String
    public let action_mroot: String
    public let schedule_version: Int
    public let producer_signature: String
}

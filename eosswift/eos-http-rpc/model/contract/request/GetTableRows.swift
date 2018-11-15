import Foundation

public struct GetTableRows : Encodable {
    public let scope: String
    public let code: String
    public let table: String
    public let table_key: String
    public let json: Bool
    public let limit: Int
    public let lower_bound: String
    public let upper_bound: String
    public let key_type: String
    public let index_position: String
    public let encode_type: String

    public init(scope: String, code: String, table: String, table_key: String, json: Bool, limit: Int, lower_bound: String, upper_bound: String, key_type: String, index_position: String, encode_type: String) {
        self.scope = scope
        self.code = code
        self.table = table
        self.table_key = table_key
        self.json = json
        self.limit = limit
        self.lower_bound = lower_bound
        self.upper_bound = upper_bound
        self.key_type = key_type
        self.index_position = index_position
        self.encode_type = encode_type
    }
}

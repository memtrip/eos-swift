import Foundation

public struct ContractTableRows : Decodable {
    public let rows: Array<[String:AnyJSONType]>
    public let more: Bool

    public init(rows: Array<[String:AnyJSONType]>, more: Bool) {
        self.rows = rows
        self.more = more
    }
}

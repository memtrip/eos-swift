import Foundation

public struct ContractTableRows : Decodable {
    public let rows: Array<[String:String]>
    public let more: Bool

    public init(rows: Array<[String:String]>, more: Bool) {
        self.rows = rows
        self.more = more
    }
}

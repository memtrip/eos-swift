import Foundation

public struct AccountResourceLimit : Codable {
    public let used: SafeInt64
    public let available: SafeInt64
    public let max: SafeInt64

    public init(used: Int64, available: Int64, max: Int64) {
        self.used = SafeInt64(value: used)
        self.available = SafeInt64(value: available)
        self.max = SafeInt64(value: max)
    }
}

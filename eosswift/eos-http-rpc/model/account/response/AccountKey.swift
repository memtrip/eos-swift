import Foundation

public struct AccountKey : Codable {
    public let key: String
    public let weight: Int

    public init(key: String, weight: Int) {
        self.key = key
        self.weight = weight
    }
}

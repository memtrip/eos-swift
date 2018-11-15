import Foundation

public struct GetProducers : Encodable {
    public let json: Bool
    public let lower_bound: String
    public let limit: Int

    public init(json: Bool, lower_bound: String, limit: Int) {
        self.json = json
        self.lower_bound = lower_bound
        self.limit = limit
    }
}

import Foundation

public struct SelfDelegatedBandwidth : Decodable {
    public let from: String
    public let to: String
    public let net_weight: String
    public let cpu_weight: String

    public init(from: String, to: String, net_weight: String, cpu_weight: String) {
        self.from = from
        self.to = to
        self.net_weight = net_weight
        self.cpu_weight = cpu_weight
    }
}

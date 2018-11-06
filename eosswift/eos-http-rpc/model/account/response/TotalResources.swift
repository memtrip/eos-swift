import Foundation

public struct TotalResources : Codable {
    public let owner: String
    public let net_weight: String
    public let cpu_weight: String
    public let ram_bytes: UInt64

    public init(owner: String, net_weight: String, cpu_weight: String, ram_bytes: UInt64) {
        self.owner = owner
        self.net_weight = net_weight
        self.cpu_weight = cpu_weight
        self.ram_bytes = ram_bytes
    }
}

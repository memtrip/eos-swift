import Foundation

public struct BandwidthJson : Decodable {
    public let from: String
    public let to: String
    public let net_weight: String
    public let cpu_weight: String
}

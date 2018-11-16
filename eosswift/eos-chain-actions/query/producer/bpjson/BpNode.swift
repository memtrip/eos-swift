import Foundation

public struct BpNode : Decodable {
    public let location: BpLocation
    public let node_type: String
    public let api_endpoint: String?
    public let ssl_endpoint: String?
    public let p2p_endpoint: String?
}

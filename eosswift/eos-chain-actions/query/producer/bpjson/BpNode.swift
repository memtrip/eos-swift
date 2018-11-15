import Foundation

struct BpNode : Decodable {
    let location: BpLocation
    let node_type: String
    let api_endpoint: String?
    let ssl_endpoint: String?
    let p2p_endpoint: String?
}

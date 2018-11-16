import Foundation

public struct BpParent : Decodable {
    public let producer_account_name: String
    public let org: BpOrg
    public let nodes: [BpNode]
}

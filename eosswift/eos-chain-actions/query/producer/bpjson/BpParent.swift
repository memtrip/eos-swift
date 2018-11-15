import Foundation

struct BpParent : Decodable {
    let producer_account_name: String
    let org: BpOrg
    let nodes: [BpNode]
}

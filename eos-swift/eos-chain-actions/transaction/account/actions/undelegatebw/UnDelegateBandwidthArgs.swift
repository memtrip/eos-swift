import Foundation

struct UnDelegateBandwidthArgs: Encodable {
    let from: AccountNameWriterValue
    let receiver: AccountNameWriterValue
    let stake_net_quantity: AssetWriterValue
    let stake_cpu_quantity: AssetWriterValue
}

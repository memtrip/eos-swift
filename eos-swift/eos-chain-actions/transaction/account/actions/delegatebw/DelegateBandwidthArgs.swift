import Foundation

struct DelegateBandwidthArgs : Encodable {
    let from: AccountNameWriterValue
    let receiver: AccountNameWriterValue
    let stake_net_quantity: AssetWriterValue
    let stake_cpu_quantity: AssetWriterValue
    let transfer: Int32
}

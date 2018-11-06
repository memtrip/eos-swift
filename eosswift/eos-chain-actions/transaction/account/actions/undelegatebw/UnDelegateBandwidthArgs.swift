import Foundation

public struct UnDelegateBandwidthArgs: Encodable {
    public let from: AccountNameWriterValue
    public let receiver: AccountNameWriterValue
    public let stake_net_quantity: AssetWriterValue
    public let stake_cpu_quantity: AssetWriterValue

    public init(from: AccountNameWriterValue, receiver: AccountNameWriterValue, stake_net_quantity: AssetWriterValue, stake_cpu_quantity: AssetWriterValue) {
        self.from = from
        self.receiver = receiver
        self.stake_net_quantity = stake_net_quantity
        self.stake_cpu_quantity = stake_cpu_quantity
    }
}

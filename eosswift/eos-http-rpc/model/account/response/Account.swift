import Foundation

public struct Account : Decodable {
    public let account_name: String
    public let head_block_num: Int
    public let head_block_time: Date
    public let privileged: Bool
    public let last_code_update: Date
    public let created: Date
    public let core_liquid_balance: String?
    public let ram_quota: SafeInt64
    public let net_weight: SafeInt64
    public let cpu_weight: SafeInt64
    public let net_limit: AccountResourceLimit
    public let cpu_limit: AccountResourceLimit
    public let ram_usage: SafeInt64
    public let permissions: Array<AccountPermission>
    public let total_resources: TotalResources?
    public let self_delegated_bandwidth: SelfDelegatedBandwidth?
    public let refund_request: RefundRequest?
    public let voter_info: VoterInfo?

    public init(account_name: String, head_block_num: Int, head_block_time: Date, privileged: Bool, last_code_update: Date, created: Date, core_liquid_balance: String?, ram_quota: SafeInt64, net_weight: SafeInt64, cpu_weight: SafeInt64, net_limit: AccountResourceLimit, cpu_limit: AccountResourceLimit, ram_usage: SafeInt64, permissions: Array<AccountPermission>, total_resources: TotalResources?, self_delegated_bandwidth: SelfDelegatedBandwidth?, refund_request: RefundRequest, voter_info: VoterInfo?) {
        self.account_name = account_name
        self.head_block_num = head_block_num
        self.head_block_time = head_block_time
        self.privileged = privileged
        self.last_code_update = last_code_update
        self.created = created
        self.core_liquid_balance = core_liquid_balance
        self.ram_quota = ram_quota
        self.net_weight = net_weight
        self.cpu_weight = cpu_weight
        self.net_limit = net_limit
        self.cpu_limit = cpu_limit
        self.ram_usage = ram_usage
        self.permissions = permissions
        self.total_resources = total_resources
        self.self_delegated_bandwidth = self_delegated_bandwidth
        self.refund_request = refund_request
        self.voter_info = voter_info
    }
}

import Foundation

struct Account : Codable {
    let account_name: String
    let head_block_num: Int
    let head_block_time: Date
    let privileged: Bool
    let last_code_update: Date
    let created: Date
    let core_liquid_balance: String?
    let ram_quota: Int64
    let net_weight: Int64
    let cpu_weight: Int64
    let net_limit: AccountResourceLimit
    let cpu_limit: AccountResourceLimit
    let ram_usage: Int64
    let permissions: Array<AccountPermission>
    let total_resources: TotalResources?
    let self_delegated_bandwidth: SelfDelegatedBandwidth?
    let voter_info: VoterInfo?
}

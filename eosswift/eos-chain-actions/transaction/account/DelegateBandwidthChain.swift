import Foundation
import RxSwift

public class DelegateBandwidthChain : ChainTransaction {

    public struct Args {
        public let from: String
        public let receiver: String
        public let netQuantity: String
        public let cpuQuantity: String
        public let transfer: Bool

        public init(from: String, receiver: String, netQuantity: String, cpuQuantity: String, transfer: Bool) {
            self.from = from
            self.receiver = receiver
            self.netQuantity = netQuantity
            self.cpuQuantity = cpuQuantity
            self.transfer = transfer
        }
    }

    private let _chainApi: ChainApi

    public init(chainApi: ChainApi) {
        self._chainApi = chainApi
    }

    public func chainApi() -> ChainApi {
        return _chainApi
    }

    public func delegateBandwidth(args: Args, transactionContext: TransactionContext) -> Single<ChainResponse<TransactionCommitted>> {
        return push(
            expirationDate: Date.defaultTransactionExpiry(),
            actions: buildAbiList(args: args, transactionContext: transactionContext),
            authorizingPrivateKey: transactionContext.authorizingPrivateKey)
    }

    private func buildAbiList(args: Args, transactionContext: TransactionContext) -> [ActionAbi] {

        let delegateBandwidthArgs: DelegateBandwidthArgs = DelegateBandwidthArgs(
            from: AccountNameWriterValue(name: args.from),
            receiver: AccountNameWriterValue(name: args.receiver),
            stake_net_quantity: AssetWriterValue(asset: args.netQuantity),
            stake_cpu_quantity: AssetWriterValue(asset: args.cpuQuantity),
            transfer: args.transfer ? 1 : 0
        )

        return [ActionAbi(
            account: AccountNameWriterValue(name: "eosio"),
            name: AccountNameWriterValue(name: "delegatebw"),
            authorization: [TransactionAuthorizationAbi(
                actor: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
                permission: AccountNameWriterValue(name: "active"))],
            data: DataWriterValue(hex: DelegateBandwidthBody(args: delegateBandwidthArgs).toHex())
            )]
    }
}

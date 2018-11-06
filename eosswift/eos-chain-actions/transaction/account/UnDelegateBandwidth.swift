import Foundation
import RxSwift

public class UnDelegateBandwidthChain : ChainTransaction {

    public struct Args {
        public let from: String
        public let receiver: String
        public let netQuantity: String
        public let cpuQuantity: String

        public init(from: String, receiver: String, netQuantity: String, cpuQuantity: String) {
            self.from = from
            self.receiver = receiver
            self.netQuantity = netQuantity
            self.cpuQuantity = cpuQuantity
        }
    }

    private let _chainApi: ChainApi

    public init(chainApi: ChainApi) {
        self._chainApi = chainApi
    }

    public func chainApi() -> ChainApi {
        return _chainApi
    }

    public func undelegateBandwidth(args: Args, transactionContext: TransactionContext) -> Single<ChainResponse<TransactionCommitted>> {
        return push(
            expirationDate: Date.defaultTransactionExpiry(),
            actions: buildAbiList(args: args, transactionContext: transactionContext),
            authorizingPrivateKey: transactionContext.authorizingPrivateKey)
    }

    private func buildAbiList(args: Args, transactionContext: TransactionContext) -> [ActionAbi] {

        let undelegateBandwidthArgs: UnDelegateBandwidthArgs = UnDelegateBandwidthArgs(
            from: AccountNameWriterValue(name: args.from),
            receiver: AccountNameWriterValue(name: args.receiver),
            stake_net_quantity: AssetWriterValue(asset: args.netQuantity),
            stake_cpu_quantity: AssetWriterValue(asset: args.cpuQuantity)
        )

        return [ActionAbi(
            account: AccountNameWriterValue(name: "eosio"),
            name: AccountNameWriterValue(name: "undelegatebw"),
            authorization: [TransactionAuthorizationAbi(
                actor: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
                permission: AccountNameWriterValue(name: "active"))],
            data: DataWriterValue(hex: UnDelegateBandwidthBody(args: undelegateBandwidthArgs).toHex())
            )]
    }
}

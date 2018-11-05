import Foundation
import RxSwift

class UnDelegateBandwidthChain : ChainTransaction {

    struct Args {
        let from: String
        let receiver: String
        let netQuantity: String
        let cpuQuantity: String
    }

    private let _chainApi: ChainApi

    init(chainApi: ChainApi) {
        self._chainApi = chainApi
    }

    func chainApi() -> ChainApi {
        return _chainApi
    }

    func delegateBandwidth(args: Args, transactionContext: TransactionContext) -> Single<ChainResponse<TransactionCommitted>> {
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

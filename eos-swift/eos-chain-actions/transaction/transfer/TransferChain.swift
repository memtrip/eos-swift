import Foundation
import RxSwift

class TransferChain : ChainTransaction {

    struct Args {
        let fromAccount: String
        let toAccount: String
        let quantity: String
        let memo: String
    }

    private let _chainApi: ChainApi

    init(chainApi: ChainApi) {
        self._chainApi = chainApi
    }

    func chainApi() -> ChainApi {
        return _chainApi
    }

    func transfer(args: Args, transactionContext: TransactionContext) -> Single<ChainResponse<TransactionCommitted>> {
        return push(
            expirationDate: Date.defaultTransactionExpiry(),
            actions: buildAbiList(args: args, transactionContext: transactionContext),
            authorizingPrivateKey: transactionContext.authorizingPrivateKey)
    }

    private func buildAbiList(args: Args, transactionContext: TransactionContext) -> [ActionAbi] {

        let transferArgs: TransferArgs = TransferArgs(
            from: AccountNameWriterValue(name: args.fromAccount),
            to: AccountNameWriterValue(name: args.toAccount),
            quantity: AssetWriterValue(asset: args.quantity),
            memo: args.memo)

        return [ActionAbi(
            account: AccountNameWriterValue(name: "eosio.token"),
            name: AccountNameWriterValue(name: "transfer"),
            authorization: [TransactionAuthorizationAbi(
                actor: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
                permission: AccountNameWriterValue(name: "active"))],
            data: DataWriterValue(hex: TransferBody(args: transferArgs).toHex())
            )]
    }
}

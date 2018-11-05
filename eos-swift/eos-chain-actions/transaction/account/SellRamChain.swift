import Foundation
import RxSwift

class SellRamChain : ChainTransaction {

    struct Args {
        let quantity: Int64
    }

    private let _chainApi: ChainApi

    init(chainApi: ChainApi) {
        self._chainApi = chainApi
    }

    func chainApi() -> ChainApi {
        return _chainApi
    }

    func sellRam(args: Args, transactionContext: TransactionContext) -> Single<ChainResponse<TransactionCommitted>> {
        return push(
            expirationDate: Date.defaultTransactionExpiry(),
            actions: buildAbiList(args: args, transactionContext: transactionContext),
            authorizingPrivateKey: transactionContext.authorizingPrivateKey)
    }

    private func buildAbiList(args: Args, transactionContext: TransactionContext) -> [ActionAbi] {

        let sellRamArgs: SellRamArgs = SellRamArgs(
            account: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
            bytes: args.quantity)

        return [ActionAbi(
            account: AccountNameWriterValue(name: "eosio"),
            name: AccountNameWriterValue(name: "sellram"),
            authorization: [TransactionAuthorizationAbi(
                actor: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
                permission: AccountNameWriterValue(name: "active"))],
            data: DataWriterValue(hex: SellRamBody(args: sellRamArgs).toHex())
            )]
    }
}

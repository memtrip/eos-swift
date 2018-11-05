import Foundation
import RxSwift

class BuyRamChain : ChainTransaction {

    struct Args {
        let receiver: String
        let quantity: String
    }

    private let _chainApi: ChainApi

    init(chainApi: ChainApi) {
        self._chainApi = chainApi
    }

    func chainApi() -> ChainApi {
        return _chainApi
    }

    func buyRam(args: Args, transactionContext: TransactionContext) -> Single<ChainResponse<TransactionCommitted>> {
        return push(
            expirationDate: Date.defaultTransactionExpiry(),
            actions: buildAbiList(args: args, transactionContext: transactionContext),
            authorizingPrivateKey: transactionContext.authorizingPrivateKey)
    }

    private func buildAbiList(args: Args, transactionContext: TransactionContext) -> [ActionAbi] {

        let buyRamArgs: BuyRamArgs = BuyRamArgs(
            payer: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
            receiver: AccountNameWriterValue(name: args.receiver),
            quant: AssetWriterValue(asset: args.quantity))

        return [ActionAbi(
            account: AccountNameWriterValue(name: "eosio"),
            name: AccountNameWriterValue(name: "buyram"),
            authorization: [TransactionAuthorizationAbi(
                actor: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
                permission: AccountNameWriterValue(name: "active"))],
            data: DataWriterValue(hex: BuyRamBody(args: buyRamArgs).toHex())
            )]
    }
}

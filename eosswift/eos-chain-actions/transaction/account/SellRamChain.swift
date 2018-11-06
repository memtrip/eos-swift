import Foundation
import RxSwift

public class SellRamChain : ChainTransaction {

    public struct Args {
        public let quantity: Int64

        public init(quantity: Int64) {
            self.quantity = quantity
        }
    }

    private let _chainApi: ChainApi

    public init(chainApi: ChainApi) {
        self._chainApi = chainApi
    }

    public func chainApi() -> ChainApi {
        return _chainApi
    }

    public func sellRam(args: Args, transactionContext: TransactionContext) -> Single<ChainResponse<TransactionCommitted>> {
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

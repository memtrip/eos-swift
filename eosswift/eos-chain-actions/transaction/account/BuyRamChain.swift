import Foundation
import RxSwift

public class BuyRamChain : ChainTransaction {

    public struct Args {
        public let receiver: String
        public let quantity: String

        public init(receiver: String, quantity: String) {
            self.receiver = receiver
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

    public func buyRam(args: Args, transactionContext: TransactionContext) -> Single<ChainResponse<TransactionCommitted>> {
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

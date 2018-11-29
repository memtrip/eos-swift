import Foundation
import RxSwift

public class TransferChain : ChainTransaction {

    public struct Args {
        public let fromAccount: String
        public let toAccount: String
        public let quantity: String
        public let memo: String

        public init(fromAccount: String, toAccount: String, quantity: String, memo: String) {
            self.fromAccount = fromAccount
            self.toAccount = toAccount
            self.quantity = quantity
            self.memo = memo
        }
    }

    private let _chainApi: ChainApi

    public init(chainApi: ChainApi) {
        self._chainApi = chainApi
    }

    public func chainApi() -> ChainApi {
        return _chainApi
    }

    public func transfer(
        contract: String,
        args: Args,
        transactionContext: TransactionContext
    ) -> Single<ChainResponse<TransactionCommitted>> {
        return push(
            expirationDate: Date.defaultTransactionExpiry(),
            actions: buildAbiList(contract: contract, args: args, transactionContext: transactionContext),
            authorizingPrivateKey: transactionContext.authorizingPrivateKey)
    }

    private func buildAbiList(
        contract: String,
        args: Args,
        transactionContext: TransactionContext
    ) -> [ActionAbi] {

        let transferArgs: TransferArgs = TransferArgs(
            from: AccountNameWriterValue(name: args.fromAccount),
            to: AccountNameWriterValue(name: args.toAccount),
            quantity: AssetWriterValue(asset: args.quantity),
            memo: args.memo)

        return [ActionAbi(
            account: AccountNameWriterValue(name: contract),
            name: AccountNameWriterValue(name: "transfer"),
            authorization: [TransactionAuthorizationAbi(
                actor: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
                permission: AccountNameWriterValue(name: "active"))],
            data: DataWriterValue(hex: TransferBody(args: transferArgs).toHex())
            )]
    }
}

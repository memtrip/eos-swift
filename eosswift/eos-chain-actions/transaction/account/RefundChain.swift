import Foundation
import RxSwift

public class RefundChain : ChainTransaction {

    private let _chainApi: ChainApi

    public init(chainApi: ChainApi) {
        self._chainApi = chainApi
    }

    public func chainApi() -> ChainApi {
        return _chainApi
    }

    public func refund(transactionContext: TransactionContext) -> Single<ChainResponse<TransactionCommitted>> {
        return push(
            expirationDate: Date.defaultTransactionExpiry(),
            actions: buildAbiList(transactionContext: transactionContext),
            authorizingPrivateKey: transactionContext.authorizingPrivateKey)
    }

    private func buildAbiList(transactionContext: TransactionContext) -> [ActionAbi] {

        let refundArgs: RefundArgs = RefundArgs(
            owner: AccountNameWriterValue(name: transactionContext.authorizingAccountName)
        )

        return [ActionAbi(
            account: AccountNameWriterValue(name: "eosio"),
            name: AccountNameWriterValue(name: "refund"),
            authorization: [TransactionAuthorizationAbi(
                actor: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
                permission: AccountNameWriterValue(name: "active"))],
            data: DataWriterValue(hex: RefundBody(args: refundArgs).toHex())
            )]
    }
}

import Foundation
import RxSwift

class VoteChain : ChainTransaction {

    struct Args {
        let voter: String
        let proxy: String
        let producers: [String]
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

        let voteArgs: VoteArgs = VoteArgs(
            voter: AccountNameWriterValue(name: args.voter),
            proxy: AccountNameWriterValue(name: args.proxy),
            producers: AccountNameCollectionWriterValue(value: args.producers))

        return [ActionAbi(
            account: AccountNameWriterValue(name: "eosio.token"),
            name: AccountNameWriterValue(name: "transfer"),
            authorization: [TransactionAuthorizationAbi(
                actor: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
                permission: AccountNameWriterValue(name: "active"))],
            data: DataWriterValue(hex: VoteBody(args: voteArgs).toHex())
            )]
    }
}

import Foundation
import RxSwift

public class VoteChain : ChainTransaction {

    public struct Args {
        public let voter: String
        public let proxy: String
        public let producers: [String]

        public init(voter: String, proxy: String, producers: [String]) {
            self.voter = voter
            self.proxy = proxy
            self.producers = producers
        }
    }

    private let _chainApi: ChainApi

    public init(chainApi: ChainApi) {
        self._chainApi = chainApi
    }

    public func chainApi() -> ChainApi {
        return _chainApi
    }

    public func vote(args: Args, transactionContext: TransactionContext) -> Single<ChainResponse<TransactionCommitted>> {
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
            account: AccountNameWriterValue(name: "eosio"),
            name: AccountNameWriterValue(name: "voteproducer"),
            authorization: [TransactionAuthorizationAbi(
                actor: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
                permission: AccountNameWriterValue(name: "active"))],
            data: DataWriterValue(hex: VoteBody(args: voteArgs).toHex())
            )]
    }
}

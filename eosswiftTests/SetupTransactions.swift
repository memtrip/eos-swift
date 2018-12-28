import Foundation
import RxSwift

@testable import eosswift

class SetupTransactions {

    let chainApi: ChainApi

    init(chainApi: ChainApi) {
        self.chainApi = chainApi
    }

    func createAccount(accountName: String, privateKey: EOSPrivateKey) throws -> Single<ChainResponse<TransactionCommitted>> {
        
        let signatureProvider = try EOSPrivateKey(base58: "5HvDsbgjH574GALj5gRcnscMfAGBQD9JSWn3sHFsD7bNrkqXqpr")

        let createAccountChain = CreateAccountChain(chainApi: chainApi)
        return createAccountChain.createAccount(
            args: CreateAccountChain.Args(
                newAccountName: accountName,
                quantity: CreateAccountChain.Quantity(
                    ram: 3248,
                    net: "0.1000 EOS",
                    cpu: "1.0000 EOS"
                ),
                ownerPublicKey: privateKey.publicKey,
                activePublicKey: privateKey.publicKey,
                transfer: true
            ),
            transactionContext: TransactionContext(
                authorizingAccountName: "memtripissue",
                authorizingPrivateKey: signatureProvider,
                expirationDate: Date.defaultTransactionExpiry()
            ),
            extraActionAbi: [])
    }

    func transfer(to: String) throws -> Single<ChainResponse<TransactionCommitted>> {
        let signatureProvider = try EOSPrivateKey(base58: "5HvDsbgjH574GALj5gRcnscMfAGBQD9JSWn3sHFsD7bNrkqXqpr")

        return TransferChain(chainApi: chainApi).transfer(
            contract: "eosio.token",
            args: TransferChain.Args(
                fromAccount: "memtripissue",
                toAccount: to,
                quantity: "0.2000 EOS",
                memo: "eos-swift test suite -> transfer"),
            transactionContext: TransactionContext(
                authorizingAccountName: "memtripissue",
                authorizingPrivateKey: signatureProvider,
                expirationDate: Date.defaultTransactionExpiry()
            )
        )
    }
}

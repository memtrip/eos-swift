import Foundation
import RxSwift

@testable import eosswift

class SetupTransactions {

    let chainApi: ChainApi

    init(chainApi: ChainApi) {
        self.chainApi = chainApi
    }

    func createAccount(accountName: String, privateKey: EOSPrivateKey) throws -> Single<ChainResponse<TransactionCommitted>> {
        
        let signatureProvider = try EOSPrivateKey(base58: "5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3")

        let createAccountChain = CreateAccountChain(chainApi: chainApi)
        return createAccountChain.createAccount(
            args: CreateAccountChain.Args(
                newAccountName: accountName,
                quantity: CreateAccountChain.Quantity(
                    ram: 20048,
                    net: "1.0000 SYS",
                    cpu: "1.0000 SYS"
                ),
                ownerPublicKey: privateKey.publicKey,
                activePublicKey: privateKey.publicKey,
                transfer: true
            ),
            transactionContext: TransactionContext(
                authorizingAccountName: "eosio",
                authorizingPrivateKey: signatureProvider,
                expirationDate: Date.defaultTransactionExpiry()
            ),
            extraActionAbi: [])
    }

    func transfer(to: String) throws -> Single<ChainResponse<TransactionCommitted>> {
        let signatureProvider = try EOSPrivateKey(base58: "5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3")

        return TransferChain(chainApi: chainApi).transfer(
            contract: "eosio.token",
            args: TransferChain.Args(
                fromAccount: "eosio",
                toAccount: to,
                quantity: "100.0000 SYS",
                memo: "here are some tokens for you to delegate to resources."),
            transactionContext: TransactionContext(
                authorizingAccountName: "eosio",
                authorizingPrivateKey: signatureProvider,
                expirationDate: Date.defaultTransactionExpiry()
            )
        )
    }
}

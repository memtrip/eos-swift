import Foundation
import XCTest

@testable import eosswift

class CreateAccountChainTests: XCTestCase {

    func testCreateAccount() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL, useLogger: true)
        let signatureProvider = try EOSPrivateKey(base58: "5HvDsbgjH574GALj5gRcnscMfAGBQD9JSWn3sHFsD7bNrkqXqpr")

        /* New account */
        let accountName = TestUtils.generateUniqueAccountName()
        let newAccountPrivateKey = try EOSPrivateKey()

        let createAccountChain = CreateAccountChain(chainApi: chainApi)
        let response = try createAccountChain.createAccount(
            args: CreateAccountChain.Args(
                newAccountName: accountName,
                quantity: CreateAccountChain.Quantity(
                    ram: 2048,
                    net: "0.0001 EOS",
                    cpu: "0.0001 EOS"
                ),
                ownerPublicKey: newAccountPrivateKey.publicKey,
                activePublicKey: newAccountPrivateKey.publicKey,
                transfer: true
            ),
            transactionContext: TransactionContext(
                authorizingAccountName: "memtripissue",
                authorizingPrivateKey: signatureProvider,
                expirationDate: Date.defaultTransactionExpiry()
            ),
            extraActionAbi: []).asObservable().toBlocking().first()

        /* Get account by public key */
        let historyApi = HistoryApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
        let accounts = try historyApi.getKeyAccounts(body: GetKeyAccounts(public_key: newAccountPrivateKey.publicKey.base58)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertTrue(accounts!.body!.account_names.count == 1)
    }
}

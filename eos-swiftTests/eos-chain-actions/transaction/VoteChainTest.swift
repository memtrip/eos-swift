import Foundation
import XCTest

@testable import eosswift

class VoteChainTests: XCTestCase {

    func testVoteForProxy() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
        let setupTransactions = SetupTransactions(chainApi: chainApi)

        let accountName = TestUtils.generateUniqueAccountName()
        let accountPrivateKey = try EOSPrivateKey()

        /* New account */
        let newAccountResponse = try setupTransactions.createAccount(accountName: accountName, privateKey: accountPrivateKey).asObservable().toBlocking().first()

        /* Transfer funds to new account */
        let transferResponse = try setupTransactions.transfer(to: accountName).asObservable().toBlocking().first()

        /* Vote */
        let voteResponse = try VoteChain(chainApi: chainApi).vote(
            args: VoteChain.Args(
                voter: accountName,
                proxy: "memtripproxy",
                producers: []),
            transactionContext: TransactionContext(authorizingAccountName: accountName, authorizingPrivateKey: accountPrivateKey, expirationDate: Date.defaultTransactionExpiry())).asObservable().toBlocking().first()

        XCTAssertTrue(newAccountResponse!.success)
        XCTAssertNotNil(newAccountResponse!.body)
        XCTAssertTrue(transferResponse!.success)
        XCTAssertNotNil(transferResponse!.body)
        XCTAssertTrue(voteResponse!.success)
        XCTAssertNotNil(voteResponse!.body)
    }

    func testVoteForProducer() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
        let setupTransactions = SetupTransactions(chainApi: chainApi)

        let accountName = TestUtils.generateUniqueAccountName()
        let accountPrivateKey = try EOSPrivateKey()

        /* New account */
        let newAccountResponse = try setupTransactions.createAccount(accountName: accountName, privateKey: accountPrivateKey).asObservable().toBlocking().first()

        /* Transfer funds to new account */
        let transferResponse = try setupTransactions.transfer(to: accountName).asObservable().toBlocking().first()

        /* Vote */
        let voteResponse = try VoteChain(chainApi: chainApi).vote(
            args: VoteChain.Args(
                voter: accountName,
                proxy: "",
                producers: ["memtripblock"]),
            transactionContext: TransactionContext(authorizingAccountName: accountName, authorizingPrivateKey: accountPrivateKey, expirationDate: Date.defaultTransactionExpiry())).asObservable().toBlocking().first()

        XCTAssertTrue(newAccountResponse!.success)
        XCTAssertNotNil(newAccountResponse!.body)
        XCTAssertTrue(transferResponse!.success)
        XCTAssertNotNil(transferResponse!.body)
        XCTAssertTrue(voteResponse!.success)
        XCTAssertNotNil(voteResponse!.body)
    }
}

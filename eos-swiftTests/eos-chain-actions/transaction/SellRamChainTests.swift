import Foundation
import XCTest

@testable import eosswift

class SellRamChainTests: XCTestCase {

    func testSellRam() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
        let setupTransactions = SetupTransactions(chainApi: chainApi)

        let accountName = TestUtils.generateUniqueAccountName()
        let accountPrivateKey = try EOSPrivateKey()

        /* New account */
        let newAccountResponse = try setupTransactions.createAccount(accountName: accountName, privateKey: accountPrivateKey).asObservable().toBlocking().first()

        /* Transfer funds to new account */
        let transferResponse = try setupTransactions.transfer(to: accountName).asObservable().toBlocking().first()

        /* Buy ram */
        let sellRamResponse = try SellRamChain(chainApi: chainApi).sellRam(
            args: SellRamChain.Args(
                quantity: 1000
            ),
            transactionContext: TransactionContext(
                authorizingAccountName: accountName,
                authorizingPrivateKey: accountPrivateKey,
                expirationDate: Date.defaultTransactionExpiry()
            )
        ).asObservable().toBlocking().first()

        XCTAssertTrue(newAccountResponse!.success)
        XCTAssertNotNil(newAccountResponse!.body)
        XCTAssertTrue(transferResponse!.success)
        XCTAssertNotNil(transferResponse!.body)
        XCTAssertTrue(sellRamResponse!.success)
        XCTAssertNotNil(sellRamResponse!.body)
    }
}

import Foundation
import XCTest

@testable import eosswift

class BuyRamChainTests: XCTestCase {

    func testBuyRam() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL, useLogger: true)
        let setupTransactions = SetupTransactions(chainApi: chainApi)

        let accountName = TestUtils.generateUniqueAccountName()
        let accountPrivateKey = try EOSPrivateKey()

        /* New account */
        let newAccountResponse = try setupTransactions.createAccount(accountName: accountName, privateKey: accountPrivateKey).asObservable().toBlocking().first()

        /* Transfer funds to new account */
        let transferResponse = try setupTransactions.transfer(to: accountName).asObservable().toBlocking().first()

        /* Ram bytes before purchase */
        let beforeAccount = try chainApi.getAccount(body: AccountName(account_name: accountName)).asObservable().toBlocking().first()
        let ramBytesBefore = beforeAccount!.body!.total_resources!.ram_bytes

        /* Buy ram */
        let buyRamResponse = try BuyRamChain(chainApi: chainApi).buyRam(
            args: BuyRamChain.Args(receiver: accountName, quantity: "0.1000 EOS"),
            transactionContext: TransactionContext(authorizingAccountName: accountName, authorizingPrivateKey: accountPrivateKey, expirationDate: Date.defaultTransactionExpiry())).asObservable().toBlocking().first()

        XCTAssertTrue(newAccountResponse!.success)
        XCTAssertNotNil(newAccountResponse!.body)
        XCTAssertTrue(transferResponse!.success)
        XCTAssertNotNil(transferResponse!.body)
        XCTAssertTrue(buyRamResponse!.success)
        XCTAssertNotNil(buyRamResponse!.body)

        /* Verify bandwidth has increased */
        let afterAccount = try chainApi.getAccount(body: AccountName(account_name: accountName)).asObservable().toBlocking().first()
        let ramBytesAfter = afterAccount!.body!.total_resources!.ram_bytes

        XCTAssertTrue(ramBytesAfter > ramBytesBefore)
    }
}

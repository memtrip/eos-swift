import Foundation
import XCTest

@testable import eosswift

class TransferChainTests: XCTestCase {

    func testTransfer() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
        let setupTransactions = SetupTransactions(chainApi: chainApi)

        let fromAccountName = TestUtils.generateUniqueAccountName()
        let fromAccountPrivateKey = try EOSPrivateKey()

        let toAccountName = TestUtils.generateUniqueAccountName()
        let toAccountPrivateKey = try EOSPrivateKey()

        /* from account */
        let fromAccountResponse = try setupTransactions.createAccount(accountName: fromAccountName, privateKey: fromAccountPrivateKey).asObservable().toBlocking().first()

        /* Transfer funds -> to account */
        let fromTransferResponse = try setupTransactions.transfer(to: fromAccountName).asObservable().toBlocking().first()

        /* to account */
        let toAccountResponse = try setupTransactions.createAccount(accountName: toAccountName, privateKey: toAccountPrivateKey).asObservable().toBlocking().first()

        /* Transfer funds -> to account */
        let toTransferResponse = try setupTransactions.transfer(to: toAccountName).asObservable().toBlocking().first()

        /* Transfer funds -> from account - to account */
        let transferResponse = try TransferChain(chainApi: chainApi).transfer(
            args: TransferChain.Args(
                fromAccount: fromAccountName,
                toAccount: toAccountName,
                quantity: "15.1234 SYS",
                memo: "leeeeeeave it."),
            transactionContext: TransactionContext(
                authorizingAccountName: fromAccountName,
                authorizingPrivateKey: fromAccountPrivateKey,
                expirationDate: Date.defaultTransactionExpiry()
            )
        ).asObservable().toBlocking().first()

        XCTAssertTrue(fromAccountResponse!.success)
        XCTAssertNotNil(fromAccountResponse!.body)
        XCTAssertTrue(fromTransferResponse!.success)
        XCTAssertNotNil(fromTransferResponse!.body)
        XCTAssertTrue(toAccountResponse!.success)
        XCTAssertNotNil(toAccountResponse!.body)
        XCTAssertTrue(toTransferResponse!.success)
        XCTAssertNotNil(toTransferResponse!.body)
        XCTAssertTrue(transferResponse!.success)
        XCTAssertNotNil(transferResponse!.body)
    }
}

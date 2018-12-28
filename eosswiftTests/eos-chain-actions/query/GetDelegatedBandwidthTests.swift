import Foundation
import RxSwift
import RxTest
import XCTest

@testable import eosswift

class GetDelegatedBandwidthTests: XCTestCase {

    func testDelegatedBandwidth() throws {
        
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL, useLogger: true)
        let setupTransactions = SetupTransactions(chainApi: chainApi)
        
        /* first account */
        let firstAccountName = TestUtils.generateUniqueAccountName()
        let firstAccountPrivateKey = try EOSPrivateKey()
        let firstAccountResponse = try setupTransactions.createAccount(accountName: firstAccountName, privateKey: firstAccountPrivateKey).asObservable().toBlocking().first()!
        let firstAccountTransferResponse = try setupTransactions.transfer(to: firstAccountName).asObservable().toBlocking().first()!
        
        /* second account */
        let secondAccountName = TestUtils.generateUniqueAccountName()
        let secondAccountPrivateKey = try EOSPrivateKey()
        let secondAccountResponse = try setupTransactions.createAccount(accountName: secondAccountName, privateKey: secondAccountPrivateKey).asObservable().toBlocking().first()!
        let secondAccountTransferResponse = try setupTransactions.transfer(to: firstAccountName).asObservable().toBlocking().first()!
        
        /* delegate first to self */
        let firstToSelfResponse = try self.delegateBw(
            fromAccountName: firstAccountName,
            toAccountName: firstAccountName,
            accountPrivateKey: firstAccountPrivateKey,
            chainApi: chainApi).asObservable().toBlocking().first()!
        
        /* delegate first to second */
        let firstToSecondResponse = try self.delegateBw(
            fromAccountName: firstAccountName,
            toAccountName: secondAccountName,
            accountPrivateKey: firstAccountPrivateKey,
            chainApi: chainApi).asObservable().toBlocking().first()!
        
        /* delegate bandwidth */
        let response = try GetDelegatedBandwidth(chainApi: chainApi).getBandwidth(accountName: firstAccountName).asObservable().toBlocking().first()!

        XCTAssertEqual(firstAccountResponse.success, true)
        XCTAssertEqual(firstAccountTransferResponse.success, true)
        XCTAssertEqual(secondAccountResponse.success, true)
        XCTAssertEqual(secondAccountTransferResponse.success, true)
        XCTAssertEqual(firstToSelfResponse.success, true)
        XCTAssertEqual(firstToSecondResponse.success, true)
        
        XCTAssertEqual(2, response.count)
        XCTAssertEqual(firstAccountName, response[0].from)
        XCTAssertEqual(firstAccountName, response[0].to)
        XCTAssertEqual("0.1001 EOS", response[0].net_weight)
        XCTAssertEqual("1.0001 EOS", response[0].cpu_weight)

        XCTAssertEqual(firstAccountName, response[1].from)
        XCTAssertEqual(secondAccountName, response[1].to)
        XCTAssertEqual("0.0001 EOS", response[1].net_weight)
        XCTAssertEqual("0.0001 EOS", response[1].cpu_weight)
    }
    
    func delegateBw(
        fromAccountName: String,
        toAccountName: String,
        accountPrivateKey: EOSPrivateKey,
        chainApi: ChainApi
    ) throws -> Single<ChainResponse<TransactionCommitted>> {
        return DelegateBandwidthChain(chainApi: chainApi).delegateBandwidth(
            args: DelegateBandwidthChain.Args(
                from: fromAccountName,
                receiver: toAccountName,
                netQuantity: "0.0001 EOS",
                cpuQuantity: "0.0001 EOS",
                transfer: false
            ),
            transactionContext: TransactionContext(
                authorizingAccountName: fromAccountName,
                authorizingPrivateKey: accountPrivateKey,
                expirationDate: Date.defaultTransactionExpiry()
            )
        )
    }
}

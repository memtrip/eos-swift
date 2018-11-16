import Foundation
import XCTest

@testable import eosswift

class BlockProducersTests: XCTestCase {

    func testBlockProducers() throws {
        let chainApi = ChainApiFactory.create(rootUrl: "http://api.eosnewyork.io/")
        let response = try GetBlockProducers(chainApi: chainApi).getProducers(limit: 50).asObservable().toBlocking().first()
        response!.forEach { blockProducer in
            XCTAssertFalse(blockProducer.apiEndpoint.count == 0)
        }
    }

    func testGetSingleBlockProducer() throws {
        let chainApi = ChainApiFactory.create(rootUrl: "http://api.eosnewyork.io/")
        let response = try GetBlockProducers(chainApi: chainApi).getSingleProducer(accountName: "eoscannonchn").asObservable().toBlocking().first()!
        XCTAssertNotNil(response.apiEndpoint.count > 0)
        XCTAssertEqual(response.bpJson.producer_account_name, "eoscannonchn")
    }
}

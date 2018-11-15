import Foundation
import XCTest

@testable import eosswift

class GetDelegatedBandwidthTests: XCTestCase {

    func testDelegatedBandwidth() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
        let response = try GetDelegatedBandwidth(chainApi: chainApi).getBandwidth(accountName: "memtripissue").asObservable().toBlocking().first()!

        XCTAssertEqual(2, response.count)
        XCTAssertEqual("memtripissue", response[0].from)
        XCTAssertEqual("memtripissue", response[0].to)
        XCTAssertEqual("200100.0000 SYS", response[0].net_weight)
        XCTAssertEqual("200100.0000 SYS", response[0].cpu_weight)

        XCTAssertEqual("memtripissue", response[1].from)
        XCTAssertEqual("memtripproxy", response[1].to)
        XCTAssertEqual("100000.0000 SYS", response[1].net_weight)
        XCTAssertEqual("100000.0000 SYS", response[1].cpu_weight)
    }
}

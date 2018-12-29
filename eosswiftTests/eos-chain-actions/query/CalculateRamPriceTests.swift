import Foundation
import XCTest

@testable import eosswift

class CalculateRamPriceTests: XCTestCase {

    func testGetRamPrice() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.MAIN_NET_API_BASE_URL)
        let response = try GetRamPrice(chainApi: chainApi).getPricePerKilobyte().asObservable().toBlocking().first()
        print(response!)
        XCTAssertTrue(response! > 0)
    }
}

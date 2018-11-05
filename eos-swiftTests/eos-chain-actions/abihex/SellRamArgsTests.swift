import Foundation
import XCTest

@testable import eos_swift

class SellRamArgsTests: XCTestCase {

    func testSellRamDecodable() {
        let sellRamArgs: SellRamArgs = SellRamArgs(
            account: AccountNameWriterValue(name: "memtripissue"),
            bytes: 4018)
        let sellRamBody: SellRamBody = SellRamBody(args: sellRamArgs)

        XCTAssertEqual(sellRamBody.toHex(), "a034c6aeba9ba592b20f000000000000")
    }
}

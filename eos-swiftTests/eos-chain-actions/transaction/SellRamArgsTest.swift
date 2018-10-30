import Foundation
import XCTest

@testable import eos_swift

class SellRamArgsTests: XCTestCase {

    func testSellRamDecodable() {
        let sellRamArgs: SellRamArgs = SellRamArgs(
            account: AccountNameWriterValue(name: "memtripissue"),
            bytes: 4018)
        let sellRamBody: SellRamBody = SellRamBody(args: sellRamArgs)

        let abiEncoder = AbiEncoder(capacity: 512)
        try! abiEncoder.encode(encodable: sellRamBody)
        let hexEncodedString = abiEncoder.toData().hexEncodedString()

        XCTAssertEqual(hexEncodedString, "a034c6aeba9ba592b20f000000000000")
    }
}

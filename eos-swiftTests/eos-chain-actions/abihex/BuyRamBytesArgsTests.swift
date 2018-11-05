import Foundation
import XCTest

@testable import eos_swift

class BuyRamBytesArgsTests: XCTestCase {

    func testBuyRamBytesDecodable() {
        let buyRamBytesArgs: BuyRamBytesArgs = BuyRamBytesArgs(
            payer: AccountNameWriterValue(name: "memtripissue"),
            receiver: AccountNameWriterValue(name: "memtripproxy"),
            bytes: 4096
        )
        let buyRamBytesBody: BuyRamBytesBody = BuyRamBytesBody(args: buyRamBytesArgs)

        XCTAssertEqual(buyRamBytesBody.toHex(), "a034c6aeba9ba592e03bbdb5ba9ba5920010000000000000")
    }
}

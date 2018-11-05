import Foundation
import XCTest

@testable import eos_swift

class BuyRamArgsTests: XCTestCase {

    func testBuyRamDecodable() {
        let buyRamArgs: BuyRamArgs = BuyRamArgs(
            payer: AccountNameWriterValue(name: "memtripissue"),
            receiver: AccountNameWriterValue(name: "memtripproxy"),
            quant: AssetWriterValue(asset: "51.2345 EOS")
        )
        let buyRamBody: BuyRamBody = BuyRamBody(args: buyRamArgs)

        XCTAssertEqual(buyRamBody.toHex(), "a034c6aeba9ba592e03bbdb5ba9ba59259d107000000000004454f5300000000")
    }
}

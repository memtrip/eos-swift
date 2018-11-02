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

        let abiEncoder = AbiEncoder(capacity: 512)
        try! abiEncoder.encode(encodable: buyRamBody)
        let hexEncodedString = abiEncoder.toData().hexEncodedString()

        XCTAssertEqual(hexEncodedString, "a034c6aeba9ba592e03bbdb5ba9ba59259d107000000000004454f5300000000")
    }
}

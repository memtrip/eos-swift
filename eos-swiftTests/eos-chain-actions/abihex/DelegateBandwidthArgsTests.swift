import Foundation
import XCTest

@testable import eos_swift

class DelegateBandwidthArgsTests: XCTestCase {

    func testDelegateBandwidthDecodable() {

        let delegateBandwidthArgs: DelegateBandwidthArgs = DelegateBandwidthArgs(
            from: AccountNameWriterValue(name: "memtripissue"),
            receiver: AccountNameWriterValue(name: "memtripproxy"),
            stake_net_quantity: AssetWriterValue(asset: "51.2345 EOS"),
            stake_cpu_quantity: AssetWriterValue(asset: "171.2345 EOS"),
            transfer: 1
        )
        let delegateBandwidthBody: DelegateBandwidthBody = DelegateBandwidthBody(args: delegateBandwidthArgs)

        XCTAssertEqual(delegateBandwidthBody.toHex(), "a034c6aeba9ba592e03bbdb5ba9ba59259d107000000000004454f5300000000d9201a000000000004454f530000000001000000")
    }
}

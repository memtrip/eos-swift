import Foundation
import XCTest

@testable import eos_swift

class UnDelegateBandwidthArgsTests: XCTestCase {

    func testUnDelegateBandwidthDecodable() {

        let unDelegateBandwidthArgs: UnDelegateBandwidthArgs = UnDelegateBandwidthArgs(
            from: AccountNameWriterValue(name: "memtripissue"),
            receiver: AccountNameWriterValue(name: "memtripproxy"),
            stake_net_quantity: AssetWriterValue(asset: "51.2345 EOS"),
            stake_cpu_quantity: AssetWriterValue(asset: "171.2345 EOS")
        )
        let unDelegateBandwidthBody: UnDelegateBandwidthBody = UnDelegateBandwidthBody(args: unDelegateBandwidthArgs)

        XCTAssertEqual(unDelegateBandwidthBody.toHex(), "a034c6aeba9ba592e03bbdb5ba9ba59259d107000000000004454f5300000000d9201a000000000004454f5300000000")
    }
}

import Foundation
import XCTest

@testable import eos_swift

class RefundArgsTests: XCTestCase {

    func testRefundDecodable() {
        let refundArgs: RefundArgs = RefundArgs(owner: AccountNameWriterValue(name: "memtripissue"))
        let refundBody: RefundBody = RefundBody(args: refundArgs)

        XCTAssertEqual(refundBody.toHex(), "a034c6aeba9ba592")
    }
}

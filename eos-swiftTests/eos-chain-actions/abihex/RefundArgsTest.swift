import Foundation
import XCTest

@testable import eosswift

class RefundArgsTests: XCTestCase {

    func testRefundDecodable() {
        let refundArgs: RefundArgs = RefundArgs(owner: AccountNameWriterValue(name: "memtripissue"))
        let refundBody: RefundBody = RefundBody(args: refundArgs)

        XCTAssertEqual(refundBody.toHex(), "a034c6aeba9ba592")
    }
}

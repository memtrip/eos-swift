import Foundation
import XCTest

@testable import eos_swift

class BlockIdDetailsTest: XCTestCase {

    func testBlockIdDetails() {
        let blockIdDetails = BlockIdDetails(blockId: "0000000ac7619ca01df1e0b4964921020e772ceb7343ec51f65537cdbce192d3")
        XCTAssertEqual(blockIdDetails.blockNum, 10)
        XCTAssertEqual(blockIdDetails.blockPrefix, 3034640669)
    }
}

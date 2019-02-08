import Foundation
import XCTest

@testable import eosswift

class BlockNumWriterTest: XCTestCase {
    
    let hexWriter = DefaultHexWriter()
    
    func testAccountName() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(BlockNumWriterValue(value: 12818018))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "6296")
    }
}

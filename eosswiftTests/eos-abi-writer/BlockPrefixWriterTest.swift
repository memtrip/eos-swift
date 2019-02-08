import Foundation
import XCTest

@testable import eosswift

class BlockPrefixWriterTest: XCTestCase {
    
    let hexWriter = DefaultHexWriter()
    
    func testAccountName() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(BlockPrefixWriterValue(value: 1992007324))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "9c9ebb76")
    }
}

import Foundation
import XCTest

@testable import eosswift

class TimestampWriterTest: XCTestCase {
    
    let hexWriter = DefaultHexWriter()
    
    func testTimestamp() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(
            TimestampWriterValue(date: Date(timeIntervalSince1970: TimeInterval(1549648892253) / 1000)))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "fcc35d5c")
    }
}

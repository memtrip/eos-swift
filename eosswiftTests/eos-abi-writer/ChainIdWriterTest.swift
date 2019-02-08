import Foundation
import XCTest

@testable import eosswift

class ChainIdWriterTest: XCTestCase {
    
    let hexWriter = DefaultHexWriter()
    
    func testAccountName() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(ChainIdWriterValue(chainId: "aca376f206b8fc25a6ed44dbdc66547c36c6c33e3a119ffbeaef943642f0e906"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "aca376f206b8fc25a6ed44dbdc66547c36c6c33e3a119ffbeaef943642f0e906")
    }
}

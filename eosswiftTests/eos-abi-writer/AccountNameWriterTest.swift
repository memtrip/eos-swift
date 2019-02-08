import Foundation
import XCTest

@testable import eosswift

class AccountNameWriterTest: XCTestCase {
    
    let hexWriter = DefaultHexWriter()
    
    func testAccountName() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(AccountNameWriterValue(name: "memtripissue"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "a034c6aeba9ba592")
    }
    
    func testName() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(NameWriterValue(name: "memtripblock"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "00118da7ba9ba592")
    }
    
    func testAccountNameCollection() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(AccountNameCollectionWriterValue(value: ["memtripissue","memtripblock"]))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "02a034c6aeba9ba59200118da7ba9ba592")
    }
}

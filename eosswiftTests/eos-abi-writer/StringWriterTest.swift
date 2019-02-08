import Foundation
import XCTest

@testable import eosswift

class StringWriterTest: XCTestCase {
    
    let hexWriter = DefaultHexWriter()
    
    func testCyrillicLetters() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode("тест")
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "08d182d0b5d181d182")
    }
    
    func testCyrillicLetters2() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode("тестируем testing 1234567890")
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "25d182d0b5d181d182d0b8d180d183d0b5d0bc2074657374696e672031323334353637383930")
    }
    
    func testAsciiString() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode("Hello there, this is a basic ascii string.")
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "2a48656c6c6f2074686572652c2074686973206973206120626173696320617363696920737472696e672e")
    }
    
    func testChineseCharacters() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode("轮子把巨人挤出局")
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "18e8bdaee5ad90e68a8ae5b7a8e4babae68ca4e587bae5b180")
    }
}

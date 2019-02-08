import Foundation
import XCTest

@testable import eosswift

class DataWriterTest: XCTestCase {
    
    let hexWriter = DefaultHexWriter()
    
    func testBuyRamWriter() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(DataWriterValue(hex: "a034c6aeba9ba592e03bbdb5ba9ba59259d107000000000004454f5300000000"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "20a034c6aeba9ba592e03bbdb5ba9ba59259d107000000000004454f5300000000")
    }
    
    func testBuyRamBytesWriter() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(DataWriterValue(hex: "a034c6aeba9ba592e03bbdb5ba9ba5920010000000000000"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "18a034c6aeba9ba592e03bbdb5ba9ba5920010000000000000")
    }
    
    func testDelegateBwWriter() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(DataWriterValue(hex: "a034c6aeba9ba592e03bbdb5ba9ba59259d107000000000004454f5300000000d9201a000000000004454f530000000001000000"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "34a034c6aeba9ba592e03bbdb5ba9ba59259d107000000000004454f5300000000d9201a000000000004454f530000000001000000")
    }
    
    func testNewAccountWriter() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(DataWriterValue(hex: "a034c6aeba9ba59200118da7ba9ba59201000000010003748f9366f5a1c2a1e04811d300b520a0715a9a9aa0ecb88bafd93923626a5e390100000001000000010003748f9366f5a1c2a1e04811d300b520a0715a9a9aa0ecb88bafd93923626a5e3901000000"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "66a034c6aeba9ba59200118da7ba9ba59201000000010003748f9366f5a1c2a1e04811d300b520a0715a9a9aa0ecb88bafd93923626a5e390100000001000000010003748f9366f5a1c2a1e04811d300b520a0715a9a9aa0ecb88bafd93923626a5e3901000000")
    }
    
    func testRefundWriter() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(DataWriterValue(hex: "a034c6aeba9ba592"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "08a034c6aeba9ba592")
    }
    
    func testSellRamWriter() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(DataWriterValue(hex: "a034c6aeba9ba592b20f000000000000"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "10a034c6aeba9ba592b20f000000000000")
    }
    
    func testTransferWriter() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(DataWriterValue(hex: "5034c6aeba9ba59200118da7ba9ba592a0e001000000000004454f530000000025d182d0b5d181d182d0b8d180d183d0b5d0bc2074657374696e672031323334353637383930"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "465034c6aeba9ba59200118da7ba9ba592a0e001000000000004454f530000000025d182d0b5d181d182d0b8d180d183d0b5d0bc2074657374696e672031323334353637383930")
    }
    
    func testUndelegateBwWriter() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(DataWriterValue(hex: "a034c6aeba9ba592e03bbdb5ba9ba59259d107000000000004454f5300000000d9201a000000000004454f5300000000"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "30a034c6aeba9ba592e03bbdb5ba9ba59259d107000000000004454f5300000000d9201a000000000004454f5300000000")
    }
    
    func testProxyVoteWriter() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(DataWriterValue(hex: "a034c6aeba9ba592e03bbdb5ba9ba59200"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "11a034c6aeba9ba592e03bbdb5ba9ba59200")
    }
    
    func testProducerVoteWriter() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(DataWriterValue(hex: "a034c6aeba9ba59200000000000000000100118da7ba9ba592"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "19a034c6aeba9ba59200000000000000000100118da7ba9ba592")
    }
}

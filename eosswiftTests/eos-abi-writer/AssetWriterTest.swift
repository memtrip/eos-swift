import Foundation
import XCTest

@testable import eosswift

class AssetWriterTest: XCTestCase {

    func testEncode() throws {
        let assetWriter = AssetWriterValue(asset: "31.0000 EOS")
        try assetWriter.encode(writer: AbiEncodingContainer(capacity: 1048))
    }
    
    func test_0_0001_EOS() throws {
 
        //. given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(AssetWriterValue(asset: "0.0001 EOS"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "010000000000000004454f5300000000")
    }
    
    func test_1000_0000_EOS() throws {
        
        //. given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(AssetWriterValue(asset: "1000.0000 EOS"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "809698000000000004454f5300000000")
    }

    func test_1000000_0000_EOS() throws {
        
        //. given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(AssetWriterValue(asset: "1000000.0000 EOS"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "00e40b540200000004454f5300000000")
    }
    
    func test_10000000000_0000_EOS() throws {
        
        //. given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(AssetWriterValue(asset: "10000000000.0000 EOS"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "00407a10f35a000004454f5300000000")
    }
    
    func test_9876_5432_EOS() throws {
        
        //. given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(AssetWriterValue(asset: "9876.5432 EOS"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "780ae3050000000004454f5300000000")
    }
    
    func test_0_1234_EOS() throws {
        
        //. given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(AssetWriterValue(asset: "0.1234 EOS"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "d20400000000000004454f5300000000")
    }
    
    func test_0_123_WALR() throws {
        
        //. given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(AssetWriterValue(asset: "0.123 WALR"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "7b000000000000000357414c52000000")
    }
    
    func test_9999_57_CHOMP() throws {
        
        //. given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(AssetWriterValue(asset: "9999.57 CHOMP"))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "15420f00000000000243484f4d500000")
    }
}

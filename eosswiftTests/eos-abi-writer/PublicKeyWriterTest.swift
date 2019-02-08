import Foundation
import XCTest

@testable import eosswift

class PublicKeyWriterTest: XCTestCase {
    
    let hexWriter = DefaultHexWriter()
    
    func testPublicKey() throws {
        
        // given
        let abiEncodingContainer = AbiEncodingContainer(capacity: 500)
        
        // when
        try abiEncodingContainer.encode(
            PublicKeyWriterValue(publicKey: try EOSPublicKey(base58: "EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV"), isCurveParamK1: true))
        let hex = abiEncodingContainer.toData().hexEncodedString()
        
        // then
        XCTAssertEqual(hex, "0002c0ded2bc1f1305fb0faac5e6c03ee3a1924234985427b6167ca569d13df435cf")
    }
}

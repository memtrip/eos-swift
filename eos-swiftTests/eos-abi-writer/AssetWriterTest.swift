import Foundation
import XCTest

@testable import eos_swift

class AssetWriterTest: XCTestCase {

    func testEncode() {
        let assetWriter = AssetWriteValue(asset: "31.0000 EOS")
        try! assetWriter.encode(writer: AbiEncodingContainer(capacity: 1048))
    }
}

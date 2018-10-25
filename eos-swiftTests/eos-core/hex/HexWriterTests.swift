import Foundation
import XCTest

@testable import eos_swift

class HexWriterTest: XCTestCase {

    func testHexWriter() {
        let hexWriter: HexWriter = DefaultHexWriter()

        let testString = "These are some bytes that should be written to a hexadecimal string representation."
        let testAsHex =  testString.data(using: .utf8)!.hexEncodedString()
        let testAsBytes = hexWriter.hexToBytes(hex: testAsHex)

        XCTAssertEqual(testString, String(bytes: testAsBytes, encoding: .utf8))
    }

    func testHexWriter2() {
        let hexWriter: HexWriter = DefaultHexWriter()

        let testString = " !#$%&()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~"
        let testAsHex = testString.data(using: .utf8)!.hexEncodedString()
        let testAsBytes = hexWriter.hexToBytes(hex: testAsHex)

        XCTAssertEqual(testString, String(bytes: testAsBytes, encoding: .utf8))
    }

    func testHexWriter3() {
        let hexWriter: HexWriter = DefaultHexWriter()

        let testString = "\\"
        let testAsHex = testString.data(using: .utf8)!.hexEncodedString()
        let testAsBytes = hexWriter.hexToBytes(hex: testAsHex)

        XCTAssertEqual(testString, String(bytes: testAsBytes, encoding: .utf8))
    }

    func testHexWriter4() {
        let hexWriter: HexWriter = DefaultHexWriter()

        let testString = "\""
        let testAsHex = testString.data(using: .utf8)!.hexEncodedString()
        let testAsBytes = hexWriter.hexToBytes(hex: testAsHex)

        XCTAssertEqual(testString, String(bytes: testAsBytes, encoding: .utf8))
    }

    func testHexWriter5() {
        let hexWriter: HexWriter = DefaultHexWriter()

        let testString = "\'"
        let testAsHex = testString.data(using: .utf8)!.hexEncodedString()
        let testAsBytes = hexWriter.hexToBytes(hex: testAsHex)

        XCTAssertEqual(testString, String(bytes: testAsBytes, encoding: .utf8))
    }
}

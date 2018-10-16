import Foundation
import XCTest

@testable import eos_swift

class Base58Test: XCTestCase {

    func testEncode() {
        let testbytes: [UInt8] = "Hello World".toUint8()
        XCTAssertEqual("JxF12TrwUP45BMd", Base58().encode(with: testbytes))
    }

    func testEncode2() {
        let testbytes: [UInt8] = "This is a longer string let us try".toUint8()
        XCTAssertEqual("2ug3Ge8gWdTgU482bhrEY3Y12UFqaHoonB59ZKmpP53jdYt", Base58().encode(with: testbytes))
    }

    func testEncode3() {
        let testbytes: [UInt8] = "This Base58 algorithm was ported from bitcoinJ".toUint8()
        XCTAssertEqual("ADezmVSRAsm47rAzFLnDhSC2t99XY4bVyFBt97B5KCgB4reEHxJFzaHsAuPHKcu", Base58().encode(with: testbytes))
    }

    func testEncode4() {
        let testbytes: [UInt8] = "eosio.token".toUint8()
        XCTAssertEqual("S9u7gkzCUATmGuj", Base58().encode(with: testbytes))
    }

    func testEncode5() {
        let testbytes: [UInt8] = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".toUint8()
        XCTAssertEqual("SxQSv8AWonnsWRyFyqRoAk1kUMEC2Xz7Q9UVuUhunVEat1Axfb3YAZRqeR1QtxBTdsnvtWzzKmidgUq", Base58().encode(with: testbytes))
    }

    func testEncode6() {
        let testbytes: [UInt8] = "!#$%&()*+,-0123456789<=>ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_abcdefghijklmnopqrstuvwxyz".toUint8()
        XCTAssertEqual("MwjAZziV1tMaFKWVMzEKMvkUhMayfkUG31shBGpdJhnuZY4HGoLzzRJSW6rArebJL1qTkg1SYtoWLCCoTh5CmXHS8XefdNPXw3kU9hXw89soP", Base58().encode(with: testbytes))
    }

    func testEncode7() {
        let testbytes: [UInt8] = " !#$%&()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~".toUint8()
        XCTAssertEqual("2h6oGRaE9s2oC7GHtSqV4ffm3kfG2Pb4gSZK9fq47mmswCvSFuzL1Fvb5SajW79j9JezrPUby2UtySPhxoY6J8iD6ndDJWuYf6FXRaveATQh7A4ACf7aKpZAf7hB33", Base58().encode(with: testbytes))
    }

    func testEncode8() {
        let testbytes: [UInt8] = "\\".toUint8()
        XCTAssertEqual("2b", Base58().encode(with: testbytes))
    }

    func testEncode9() {
        let testbytes: [UInt8] = "\"".toUint8()
        XCTAssertEqual("b", Base58().encode(with: testbytes))
    }

    func testEncode10() {
        let testbytes: [UInt8] = "\'".toUint8()
        XCTAssertEqual("g", Base58().encode(with: testbytes))
    }
}

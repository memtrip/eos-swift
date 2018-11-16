import Foundation
import XCTest

@testable import eosswift

class EOSPrivateKeyTests: XCTestCase {

    func testEOSPrivateKey() {
        let eosPrivateKey = try! EOSPrivateKey()
        let base58Respresentation = eosPrivateKey.base58
        // verify encoded checksum
        let eosPrivateKeyFromWifi = try! EOSPrivateKey(base58: base58Respresentation)
        XCTAssertEqual(eosPrivateKey.base58, eosPrivateKeyFromWifi.base58)
    }

    func testEOSPrivateKeyFromString() {
        let eosPrivateKey = try! EOSPrivateKey(base58: "5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3")
        let eosPrivateKeyFromBytes = EOSPrivateKey(ecKeyPrivateKey: ECPrivateKey(privKeyData: eosPrivateKey.bytes()))
        XCTAssertEqual(eosPrivateKey.base58, eosPrivateKeyFromBytes.base58)
    }
}

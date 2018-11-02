import Foundation
import XCTest

@testable import eos_swift

class EOSPublicKeyTests: XCTestCase {

    func testEOSPublicKey() throws {
        let eosPublicKey = try EOSPublicKey(base58: "EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV")
        XCTAssertEqual("EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV", eosPublicKey.base58)

        let eosPublicKeyFromBytes = EOSPublicKey(bytes: eosPublicKey.bytes())
        XCTAssertEqual(eosPublicKeyFromBytes.base58, eosPublicKey.base58)
    }

    func testEOSPublicKeyFromPrivateKey() throws {
        let eosPrivateKey = try EOSPrivateKey()
        let eosPublicKey = eosPrivateKey.publicKey

        let eosPublicKeyFromBytes = EOSPublicKey(bytes: eosPublicKey.bytes())
        XCTAssertEqual(eosPublicKeyFromBytes.base58, eosPublicKey.base58)
    }

    func testSignatureProviderEOSPublicKey() throws {
        let eosPrivateKey = try EOSPrivateKey(base58: "5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3")
        XCTAssertEqual("EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV", eosPrivateKey.publicKey.base58)
    }
}

import Foundation
import XCTest

@testable import eos_swift

class NewAccountArgsTests: XCTestCase {

    func testNewAccountDecodable() {

        let eosPublicKey = try! EOSPublicKey(base58: "EOS7iZvLHdreeArYBGGat3Ciky5eR8mwBt1TD8pekcGEZCe1gVVQH")

        let newAccountArgs: NewAccountArgs = NewAccountArgs(
            creator: AccountNameWriterValue(name: "memtripissue"),
            name: AccountNameWriterValue(name: "memtripblock"),
            owner: AccountRequiredAuthAbi(
                threshold: 1,
                keys: [
                    AccountKeyAbi(
                        key: PublicKeyWriterValue(publicKey: eosPublicKey, isCurveParamK1: true),
                        weight: 1)
                ],
                accounts: StringCollectionWriterValue(value: []),
                waits:StringCollectionWriterValue(value: [])
            ),
            active: AccountRequiredAuthAbi(
                threshold: 1,
                keys: [
                    AccountKeyAbi(
                        key: PublicKeyWriterValue(publicKey: eosPublicKey, isCurveParamK1: true),
                        weight: 1)
                ],
                accounts: StringCollectionWriterValue(value: []),
                waits:StringCollectionWriterValue(value: [])
            )
        )

        let newAccountBody: NewAccountBody = NewAccountBody(args: newAccountArgs)

        let abiEncoder = AbiEncoder(capacity: 512)
        try! abiEncoder.encode(encodable: newAccountBody)
        let hexEncodedString = abiEncoder.toData().hexEncodedString()

        XCTAssertEqual(hexEncodedString, "a034c6aeba9ba59200118da7ba9ba59201000000010003748f9366f5a1c2a1e04811d300b520a0715a9a9aa0ecb88bafd93923626a5e390100000001000000010003748f9366f5a1c2a1e04811d300b520a0715a9a9aa0ecb88bafd93923626a5e3901000000")
    }
}

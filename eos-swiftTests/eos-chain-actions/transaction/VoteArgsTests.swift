import Foundation
import XCTest

@testable import eos_swift

class VoteArgsTests: XCTestCase {

    func testProxyVoteDecodable() {
        let voteArgs: VoteArgs = VoteArgs(
            voter: AccountNameWriterValue(name: "memtripissue"),
            proxy: AccountNameWriterValue(name: "memtripproxy"),
            producers: AccountNameCollectionWriterValue(value: []))
        let voteBody: VoteBody = VoteBody(args: voteArgs)

        let abiEncoder = AbiEncoder(capacity: 512)
        try! abiEncoder.encode(encodable: voteBody)
        let hexEncodedString = abiEncoder.toData().hexEncodedString()

        XCTAssertEqual(hexEncodedString, "a034c6aeba9ba592e03bbdb5ba9ba59200")
    }

    func testProducerVoteDecodable() {
        let voteArgs: VoteArgs = VoteArgs(
            voter: AccountNameWriterValue(name: "memtripissue"),
            proxy: AccountNameWriterValue(name: ""),
            producers: AccountNameCollectionWriterValue(value: ["memtripblock"]))
        let voteBody: VoteBody = VoteBody(args: voteArgs)

        let abiEncoder = AbiEncoder(capacity: 512)
        try! abiEncoder.encode(encodable: voteBody)
        let hexEncodedString = abiEncoder.toData().hexEncodedString()

        XCTAssertEqual(hexEncodedString, "a034c6aeba9ba59200000000000000000100118da7ba9ba592")
    }
}

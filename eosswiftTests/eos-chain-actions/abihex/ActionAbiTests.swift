import Foundation
import XCTest

@testable import eosswift

class ActionAbiTests: XCTestCase {

    func testActionAbiDecodable() throws {
        let createBuyRamBytes = try createBuyRamBytesAbi()
        let actionAbi = ActionAbi(
            account: AccountNameWriterValue(name: "eosio"),
            name: AccountNameWriterValue(name: "buyrambytes"),
            authorization: [TransactionAuthorizationAbi(
                actor: AccountNameWriterValue(name: "memtripissue"),
                permission: AccountNameWriterValue(name: "active"))],
            data: DataWriterValue(hex: createBuyRamBytes))

        XCTAssertEqual("a034c6aeba9ba592e03bbdb5ba9ba5920010000000000000", createBuyRamBytes)
        XCTAssertEqual(actionAbi.toHex(), "0000000000ea305500b0cafe4873bd3e01a034c6aeba9ba59200000000a8ed323218a034c6aeba9ba592e03bbdb5ba9ba5920010000000000000")
    }

    private func createBuyRamBytesAbi() throws -> String {
        let buyRamBytesArgs: BuyRamBytesArgs = BuyRamBytesArgs(
            payer: AccountNameWriterValue(name: "memtripissue"),
            receiver: AccountNameWriterValue(name: "memtripproxy"),
            bytes: 4096
        )
        let buyRamBytesBody: BuyRamBytesBody = BuyRamBytesBody(args: buyRamBytesArgs)

        let abiEncoder = AbiEncoder(capacity: 512)
        try abiEncoder.encode(encodable: buyRamBytesBody)
        return abiEncoder.toData().hexEncodedString()
    }
}

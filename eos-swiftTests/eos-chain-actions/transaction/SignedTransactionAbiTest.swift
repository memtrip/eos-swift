import Foundation
import XCTest

@testable import eos_swift

class SignedTransactionAbiTest: XCTestCase {

    func testSignedTransactionAbiDecodable() {

        let chainId = "cf057bbfb72640471fd910bcb67639c22df9f92470936cddc1ade0e2f2e7dc4f"
        let blockId = "0000000ac7619ca01df1e0b4964921020e772ceb7343ec51f65537cdbce192d3"
        let blockIdDetails = BlockIdDetails(blockId: blockId)
        let accountName = "memtripissue"
        let expirationDate = Date(timeIntervalSince1970: 1541086024002)
        let createNewAccountAbiHex = self.createNewAccountAbi()
        let buyRamBytesAbi = self.buyRamBytesAbi()
        let delegateBandwidthAbiHex = self.delegateBandwidthAbi()

        let transactionAbi = TransactionAbi(
            expiration: TimestampWriterValue(date: expirationDate),
            ref_block_num: BlockNumWriterValue(value: blockIdDetails.blockNum),
            ref_block_prefix: BlockPrefixWriterValue(value: blockIdDetails.blockPrefix),
            max_net_usage_words: 0,
            max_cpu_usage_ms: 0,
            delay_sec: 0,
            context_free_actions: [],
            actions: [
                ActionAbi(
                    account: AccountNameWriterValue(name: "eosio"),
                    name: AccountNameWriterValue(name: "newaccount"),
                    authorization: [TransactionAuthorizationAbi(
                        actor: AccountNameWriterValue(name: accountName),
                        permission: AccountNameWriterValue(name: "active"))],
                    data: DataWriterValue(hex: createNewAccountAbiHex)),
                ActionAbi(
                    account: AccountNameWriterValue(name: "eosio"),
                    name: AccountNameWriterValue(name: "buyrambytes"),
                    authorization: [TransactionAuthorizationAbi(
                        actor: AccountNameWriterValue(name: accountName),
                        permission: AccountNameWriterValue(name: "active"))],
                    data: DataWriterValue(hex: buyRamBytesAbi)),
                ActionAbi(
                    account: AccountNameWriterValue(name: "eosio"),
                    name: AccountNameWriterValue(name: "delegatebw"),
                    authorization: [TransactionAuthorizationAbi(
                        actor: AccountNameWriterValue(name: accountName),
                        permission: AccountNameWriterValue(name: "active"))],
                    data: DataWriterValue(hex: delegateBandwidthAbiHex))
            ],
            transaction_extensions: StringCollectionWriterValue(value: []),
            signatures: StringCollectionWriterValue(value: []),
            context_free_data: StringCollectionWriterValue(value: []))

        let signedTransactionAbi = SignedTransactionAbi(
            chainId: ChainIdWriterValue(chainId: chainId),
            transaction: transactionAbi,
            context_free_data: HexCollectionWriterValue(value: []))

        let abiEncoder = AbiEncoder(capacity: 512)
        try! abiEncoder.encode(encodable: signedTransactionAbi)
        let signedTransactionAbiHex = abiEncoder.toData().hexEncodedString()

        XCTAssertEqual(createNewAccountAbiHex, "a034c6aeba9ba59200118da7ba9ba59201000000010003748f9366f5a1c2a1e04811d300b520a0715a9a9aa0ecb88bafd93923626a5e390100000001000000010003748f9366f5a1c2a1e04811d300b520a0715a9a9aa0ecb88bafd93923626a5e3901000000")
        XCTAssertEqual(buyRamBytesAbi, "a034c6aeba9ba592e03bbdb5ba9ba5920010000000000000")
        XCTAssertEqual(delegateBandwidthAbiHex, "a034c6aeba9ba592e03bbdb5ba9ba59259d107000000000004454f5300000000d9201a000000000004454f530000000001000000")
        XCTAssertEqual(signedTransactionAbiHex, "cf057bbfb72640471fd910bcb67639c22df9f92470936cddc1ade0e2f2e7dc4f481bdb5b0a001df1e0b400000000030000000000ea305500409e9a2264b89a01a034c6aeba9ba59200000000a8ed323266a034c6aeba9ba59200118da7ba9ba59201000000010003748f9366f5a1c2a1e04811d300b520a0715a9a9aa0ecb88bafd93923626a5e390100000001000000010003748f9366f5a1c2a1e04811d300b520a0715a9a9aa0ecb88bafd93923626a5e39010000000000000000ea305500b0cafe4873bd3e01a034c6aeba9ba59200000000a8ed323218a034c6aeba9ba592e03bbdb5ba9ba59200100000000000000000000000ea305500003f2a1ba6a24a01a034c6aeba9ba59200000000a8ed323234a034c6aeba9ba592e03bbdb5ba9ba59259d107000000000004454f5300000000d9201a000000000004454f5300000000010000000000000000000000000000000000000000000000000000000000000000000000000000")
    }

    private func createNewAccountAbi() -> String {
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
                waits: StringCollectionWriterValue(value: [])
            ),
            active: AccountRequiredAuthAbi(
                threshold: 1,
                keys: [
                    AccountKeyAbi(
                        key: PublicKeyWriterValue(publicKey: eosPublicKey, isCurveParamK1: true),
                        weight: 1)
                ],
                accounts: StringCollectionWriterValue(value: []),
                waits: StringCollectionWriterValue(value: [])
            )
        )

        let newAccountBody: NewAccountBody = NewAccountBody(args: newAccountArgs)

        let abiEncoder = AbiEncoder(capacity: 512)
        try! abiEncoder.encode(encodable: newAccountBody)
        return abiEncoder.toData().hexEncodedString()
    }

    private func buyRamBytesAbi() -> String {
        let buyRamBytesArgs: BuyRamBytesArgs = BuyRamBytesArgs(
            payer: AccountNameWriterValue(name: "memtripissue"),
            receiver: AccountNameWriterValue(name: "memtripproxy"),
            bytes: 4096
        )
        let buyRamBytesBody: BuyRamBytesBody = BuyRamBytesBody(args: buyRamBytesArgs)

        let abiEncoder = AbiEncoder(capacity: 512)
        try! abiEncoder.encode(encodable: buyRamBytesBody)
        return abiEncoder.toData().hexEncodedString()
    }

    private func delegateBandwidthAbi() -> String {
        let delegateBandwidthArgs: DelegateBandwidthArgs = DelegateBandwidthArgs(
            from: AccountNameWriterValue(name: "memtripissue"),
            receiver: AccountNameWriterValue(name: "memtripproxy"),
            stake_net_quantity: AssetWriterValue(asset: "51.2345 EOS"),
            stake_cpu_quantity: AssetWriterValue(asset: "171.2345 EOS"),
            transfer: 1
        )
        let delegateBandwidthBody: DelegateBandwidthBody = DelegateBandwidthBody(args: delegateBandwidthArgs)

        let abiEncoder = AbiEncoder(capacity: 512)
        try! abiEncoder.encode(encodable: delegateBandwidthBody)
        return abiEncoder.toData().hexEncodedString()
    }
}

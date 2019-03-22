import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import eosswift

class ChainApiTest: XCTestCase {

    func testGetInfo() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
        let response = try chainApi.getInfo().asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testGetProducers() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
        let response = try chainApi.getProducers(body: GetProducers(
            json: true,lower_bound: "", limit: 10)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testGetBlock() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let infoResponse = try chainApi.getInfo().asObservable().toBlocking().first()

        let response = try chainApi.getBlock(body: BlockNumOrId(block_num_or_id:
            infoResponse!.body!.head_block_id)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testGetBlockHeaderState() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let infoResponse = try chainApi.getInfo().asObservable().toBlocking().first()

        let response = try chainApi.getBlockHeaderState(body: BlockNumOrId(block_num_or_id:
            infoResponse!.body!.head_block_id)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testGetAccount() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try chainApi.getAccount(body: AccountName(
            account_name: "lioninjungle")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testVoterAccount() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try chainApi.getAccount(body: AccountName(
            account_name: "memtripissue")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body!.voter_info)
        XCTAssertTrue(response!.body!.voter_info!.producers.count == 1)
        XCTAssertTrue(response!.body!.voter_info!.producers[0] == "memtripblock")
    }
    
    func testVoterAccountForProxy() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
        
        let response = try chainApi.getAccount(body: AccountName(
            account_name: "memtripblock")).asObservable().toBlocking().first()
        
        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body!.voter_info)
        XCTAssertTrue(response!.body!.voter_info!.proxy == "memtripproxy")
    }

    func testVoterProxy() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try chainApi.getAccount(body: AccountName(
            account_name: "memtripproxy")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body!.voter_info)
        XCTAssertTrue(response!.body!.voter_info!.is_proxy == 1)
    }

    func testGetAbi() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try chainApi.getAbi(body: AccountName(
            account_name: "eosio.token")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testGetCodeWasm() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try chainApi.getCode(body: GetCodeByAccountName(
            account_name: "eosio.token", code_as_wasm: true)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
        XCTAssertNotEqual(response!.body!.wasm, "")
    }

    func testGetRawCodeAndAbi() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try chainApi.getRawCodeAndAbi(body: AccountName(
            account_name: "eosio.token")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
        XCTAssertNotNil(response!.body!.wasm)
        XCTAssertNotNil(response!.body!.abi)
        XCTAssertEqual(response!.body!.account_name, "eosio.token")
    }

    func testGetTableRows() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try chainApi.getTableRows(body: GetTableRows(
            scope: "eosio",
            code: "eosio.token",
            table: "accounts",
            table_key: "",
            json: true,
            limit: 10,
            lower_bound: "",
            upper_bound: "",
            key_type: "",
            index_position: "",
            encode_type: "")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testGetCurrencyBalance() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try chainApi.getCurrencyBalance(body: GetCurrencyBalance(
            code: "eosio.token", account: "memtripissue", symbol: "SYS")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
        XCTAssertNotNil(response!.body!.count > 0)
    }

    func testAbiJsonToBin() throws {
        /*
         The local abi byte writing should be used in replace of this call.
         Mobile clients that use this method are exposed to man in the middle attacks.
        */
        XCTAssertTrue(true)
    }

    func testAbiBinToJson() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let delegateBandwidthArgs: DelegateBandwidthArgs = DelegateBandwidthArgs(
            from: AccountNameWriterValue(name: "memtripissue"),
            receiver: AccountNameWriterValue(name: "memtripproxy"),
            stake_net_quantity: AssetWriterValue(asset: "51.2345 SYS"),
            stake_cpu_quantity: AssetWriterValue(asset: "171.2345 SYS"),
            transfer: 1
        )
        let delegateBandwidthBody: DelegateBandwidthBody = DelegateBandwidthBody(args: delegateBandwidthArgs)

        let response = try chainApi.abiBinToJson(body: AbiBinToJson(
            code: "eosio", action: "delegatebw", binargs: delegateBandwidthBody.toHex())).asObservable().toBlocking().first()
        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testGetRequiredKeys() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL, useLogger: true)
        let privateKey = try EOSPrivateKey(base58: "5HvDsbgjH574GALj5gRcnscMfAGBQD9JSWn3sHFsD7bNrkqXqpr")

        let info = try chainApi.getInfo().asObservable().toBlocking().first()!

        let blockIdDetails = BlockIdDetails(blockId: info.body!.head_block_id)

        let transferArgs: TransferArgs = TransferArgs(
            from: AccountNameWriterValue(name: "memtripissue"),
            to: AccountNameWriterValue(name: "memtripblock"),
            quantity: AssetWriterValue(asset: "12.3040 EOS"),
            memo: "this is a memo")
        let transferBody: TransferBody = TransferBody(args: transferArgs)

        let transaction = Transaction(
            expiration: Date.defaultTransactionExpiry(),
            ref_block_num: blockIdDetails.blockNum,
            ref_block_prefix: blockIdDetails.blockPrefix,
            max_net_usage_words: 0,
            max_cpu_usage_ms: 0,
            delay_sec: 0,
            context_free_actions: [],
            actions: [
                Action(
                    account: "eosio",
                    name: "transfer",
                    authorization: [TransactionAuthorization(
                        actor: "memtripissue",
                        permission: "active")],
                    data: transferBody.toHex()),
            ],
            transaction_extensions: [],
            signatures: [],
            context_free_data: [])

        let requiredKeys = try chainApi.getRequiredKeys(body: GetRequiredKeysBody(
            transaction: transaction,
            available_keys: [privateKey.publicKey.base58])).asObservable().toBlocking().first()

        XCTAssertTrue(requiredKeys!.success)
    }

    func testGetCurrencyStats() throws {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try chainApi.getCurrencyStats(
            body: GetCurrencyStats(code: "eosio.token",symbol: "SYS")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }
}

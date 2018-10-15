import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import eos_swift

class ChainApiTest: XCTestCase {

    func testGetInfo() {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
        let response = try! chainApi.getInfo().asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testGetProducers() {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
        let response = try! chainApi.getProducers(body: GetProducers(
            json: true,lower_bound: "", limit: 10)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testGetBlock() {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let infoResponse = try! chainApi.getInfo().asObservable().toBlocking().first()

        let response = try! chainApi.getBlock(body: BlockNumOrId(block_num_or_id:
            infoResponse!.body!.head_block_id)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testGetBlockHeaderState() {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let infoResponse = try! chainApi.getInfo().asObservable().toBlocking().first()

        let response = try! chainApi.getBlockHeaderState(body: BlockNumOrId(block_num_or_id:
            infoResponse!.body!.head_block_id)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testAccount() {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try! chainApi.getAccount(body: AccountName(
            account_name: "eosio.token")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testVoterAccount() {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try! chainApi.getAccount(body: AccountName(
            account_name: "memtripadmin")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body!.voter_info)
        XCTAssertTrue(response!.body!.voter_info!.producers.count == 0)
    }

    func testVoterProxy() {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try! chainApi.getAccount(body: AccountName(
            account_name: "memtripproxy")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body!.voter_info)
        XCTAssertTrue(response!.body!.voter_info!.is_proxy == 1)
    }

    func testGetAbi() {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try! chainApi.getAbi(body: AccountName(
            account_name: "eosio.token")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testGetCodeWasm() {
        // failing
//        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
//
//        let response = try! chainApi.getCode(body: GetCodeByAccountName(
//            account_name: "eosio.token", code_as_wasm: true)).asObservable().toBlocking().first()
//
//        XCTAssertTrue(response!.success)
//        XCTAssertNotNil(response!.body)
//        XCTAssertNotEqual(response!.body!.wasm, "")
        XCTAssertTrue(false)
    }

    func testGetCodeWast() {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try! chainApi.getCode(body: GetCodeByAccountName(
            account_name: "eosio.token", code_as_wasm: false)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
        XCTAssertNotNil(response!.body!.wast, "")
    }

    func testGetRawCodeAndAbi() {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try! chainApi.getRawCodeAndAbi(body: AccountName(
            account_name: "eosio.token")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
        XCTAssertNotNil(response!.body!.wasm)
        XCTAssertNotNil(response!.body!.abi)
        XCTAssertEqual(response!.body!.account_name, "eosio.token")
    }

    func testGetTableRows() {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try! chainApi.getTableRows(body: GetTableRows(
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

    func testGetCurrencyBalance() {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try! chainApi.getCurrencyBalance(body: GetCurrencyBalance(
            code: "eosio.token", account: "memtripissue", symbol: "SYS")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
        XCTAssertNotNil(response!.body!.count > 0)
    }

    func testAbiJsonToBin() {
        // TODO
        XCTAssertTrue(false)
    }

    func testAbiBinToJson() {
        // TODO
        XCTAssertTrue(false)
    }

    func testGetRequiredKeys() {
        // TODO - requires byte writer
        XCTAssertTrue(false)
    }

    func testGetCurrencyStats() {
        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)

        let response = try! chainApi.getCurrencyStats(
            body: GetCurrencyStats(code: "eosio.token",symbol: "SYS")).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }

    func testPushTransaction() {
        // TODO - requires byte writer
//        let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
//
//        let response = try! chainApi.pushTransaction(
//            body: PushTransaction(signatures: [], compression: "", packed_context_free_data: "", packed_trx: "")
//        ).asObservable().toBlocking().first()
//
//        XCTAssertTrue(response!.success)
//        XCTAssertNotNil(response!.body)
    }
}

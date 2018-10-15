import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import eos_swift

class HistoryApiTest: XCTestCase {

    func testGetActions() {
        let historyApi = HistoryApiFactory.create(rootUrl: Config.HISTORY_API_BASE_URL)

        let response = try! historyApi.getActions(
            body: GetActions(account_name: "eosio.token", pos: nil, offset: nil)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
        XCTAssertTrue(response!.body!.actions.count > 0)
    }

    func testGetActionsPagination() {
        let historyApi = HistoryApiFactory.create(rootUrl: Config.HISTORY_API_BASE_URL)

        let responseSetOne = try! historyApi.getActions(
            body: GetActions(account_name: "eosio.token", pos: -1, offset: -20)).asObservable().toBlocking().first()
        let firstPageActionsItems = responseSetOne!.body!.actions

        let responseSetTwo = try! historyApi.getActions(body: GetActions(
            account_name: "eosio.token",
            pos: firstPageActionsItems[firstPageActionsItems.count - 1].account_action_seq - 1,
            offset: -20
        )).asObservable().toBlocking().first()

        XCTAssertTrue(responseSetOne!.success)
        XCTAssertTrue(responseSetOne!.body!.actions.count == 20)

        XCTAssertTrue(responseSetTwo!.success)
        XCTAssertTrue(responseSetTwo!.body!.actions.count == 21)
    }

    func testGetActionsOutOfRange() {
        let historyApi = HistoryApiFactory.create(rootUrl: Config.HISTORY_API_BASE_URL)

        let response = try! historyApi.getActions(
            body: GetActions(account_name: "eosio.token", pos: -1, offset: 100000)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
        XCTAssertTrue(response!.body!.actions.count == 0)
    }

    func testGetKeyAccounts() {
        // TODO - requires pub/priv key implementation
        XCTAssertTrue(false)
    }

    func testGetTransaction() {
        let historyApi = HistoryApiFactory.create(rootUrl: Config.HISTORY_API_BASE_URL)

        let actionsResponse = try! historyApi.getActions(
            body: GetActions(account_name: "eosio.token", pos: nil, offset: nil)).asObservable().toBlocking().first()
        let action = actionsResponse!.body!.actions[0]

        let response = try! historyApi.getTransaction(body: GetTransaction(id: action.action_trace.trx_id)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }
}

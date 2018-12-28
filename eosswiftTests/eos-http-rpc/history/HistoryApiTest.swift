import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import eosswift

class HistoryApiTest: XCTestCase {

    func testGetActions() throws {
        let historyApi = HistoryApiFactory.create(rootUrl: Config.HISTORY_API_BASE_URL, useLogger: true)

        let response = try historyApi.getActions(
            body: GetActions(account_name: "memtripissue", pos: nil, offset: nil)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
        XCTAssertTrue(response!.body!.actions.count > 0)
    }

    func testGetActionsPagination() throws {
        let historyApi = HistoryApiFactory.create(rootUrl: Config.HISTORY_API_BASE_URL)

        let responseSetOne = try historyApi.getActions(
            body: GetActions(account_name: "memtripissue", pos: -1, offset: -20)).asObservable().toBlocking().first()
        let firstPageActionsItems = responseSetOne!.body!.actions

        let responseSetTwo = try historyApi.getActions(body: GetActions(
            account_name: "memtripissue",
            pos: firstPageActionsItems[firstPageActionsItems.count - 1].account_action_seq - 1,
            offset: -20
        )).asObservable().toBlocking().first()

        XCTAssertTrue(responseSetOne!.success)
        XCTAssertTrue(responseSetOne!.body!.actions.count == 20)

        XCTAssertTrue(responseSetTwo!.success)
        XCTAssertTrue(responseSetTwo!.body!.actions.count == 21)
    }

    func testGetActionsOutOfRange() throws {
        let historyApi = HistoryApiFactory.create(rootUrl: Config.HISTORY_API_BASE_URL)

        let response = try historyApi.getActions(
            body: GetActions(account_name: "memtripissue", pos: -1, offset: 100000)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
        XCTAssertTrue(response!.body!.actions.count == 0)
    }

    func testGetKeyAccounts() throws {

        let historyApi = HistoryApiFactory.create(rootUrl: Config.HISTORY_API_BASE_URL)

        let accounts = try historyApi.getKeyAccounts(body: GetKeyAccounts(public_key: "EOS5BMFrhdz9G1efQQYJt2XbnrnLeUaFDuh15j2qYsQ3ioDGaB6js"))
            .asObservable().toBlocking().first()!

        XCTAssertTrue(accounts.success)
        XCTAssertNotNil(accounts.body)
        XCTAssertTrue(accounts.body!.account_names.count > 0)
    }

    func testGetTransaction() throws {
        let historyApi = HistoryApiFactory.create(rootUrl: Config.HISTORY_API_BASE_URL)

        let actionsResponse = try historyApi.getActions(
            body: GetActions(account_name: "memtripissue", pos: nil, offset: nil)).asObservable().toBlocking().first()
        let action = actionsResponse!.body!.actions[0]

        let response = try historyApi.getTransaction(body: GetTransaction(id: action.action_trace.trx_id)).asObservable().toBlocking().first()

        XCTAssertTrue(response!.success)
        XCTAssertNotNil(response!.body)
    }
}

import Foundation
import RxSwift

protocol HistoryApi {

    func getActions(body: GetActions) -> Single<HttpResponse<HistoricAccountActionParent>>

    func getTransaction(body: GetTransaction) -> Single<HttpResponse<HistoricTransaction>>

    func getKeyAccounts(body: GetKeyAccounts) -> Single<HttpResponse<Accounts>>

    func getControlledAccounts(body: GetControlledAccounts) -> Single<HttpResponse<Accounts>>
}

class HistoryApiImpl : HistoryApi {

    let rootUrl: String

    fileprivate init(rootUrl: String) {
        self.rootUrl = rootUrl
    }

    func getActions(body: GetActions) -> Single<HttpResponse<HistoricAccountActionParent>> {
        return RxHttp<GetActions, HistoricAccountActionParent, ChainError>().single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/history/get_actions",
                method: "POST",
                body: body
            )
        )
    }

    func getTransaction(body: GetTransaction) -> Single<HttpResponse<HistoricTransaction>> {
        return RxHttp<GetTransaction, HistoricTransaction, ChainError>().single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/history/get_transaction",
                method: "POST",
                body: body
            )
        )
    }

    func getKeyAccounts(body: GetKeyAccounts) -> Single<HttpResponse<Accounts>> {
        return RxHttp<GetKeyAccounts, Accounts, ChainError>().single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/history/get_key_accounts",
                method: "POST",
                body: body
            )
        )
    }

    func getControlledAccounts(body: GetControlledAccounts) -> Single<HttpResponse<Accounts>> {
        return RxHttp<GetControlledAccounts, Accounts, ChainError>().single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/history/get_controlled_accounts",
                method: "POST",
                body: body
            )
        )
    }
}

class HistoryApiFactory {
    static func create(rootUrl: String) -> HistoryApi {
        return HistoryApiImpl(rootUrl: rootUrl)
    }
}

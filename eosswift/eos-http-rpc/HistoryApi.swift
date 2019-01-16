import Foundation
import RxSwift

public protocol HistoryApi {

    func getActions(body: GetActions) -> Single<HttpResponse<HistoricAccountActionParent>>

    func getTransaction(body: GetTransaction) -> Single<HttpResponse<HistoricTransaction>>

    func getKeyAccounts(body: GetKeyAccounts) -> Single<HttpResponse<Accounts>>

    func getControlledAccounts(body: GetControlledAccounts) -> Single<HttpResponse<Accounts>>
}

class HistoryApiImpl : HistoryApi {

    private let rootUrl: String
    private let urlSession: URLSession
    private let useLogger: Bool

    fileprivate init(rootUrl: String, urlSession: URLSession, useLogger: Bool) {
        self.rootUrl = rootUrl
        self.urlSession = urlSession
        self.useLogger = useLogger
    }

    func getActions(body: GetActions) -> Single<HttpResponse<HistoricAccountActionParent>> {
        return RxHttp<GetActions, HistoricAccountActionParent, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/history/get_actions",
                method: "POST",
                body: body
            )
        )
    }

    func getTransaction(body: GetTransaction) -> Single<HttpResponse<HistoricTransaction>> {
        return RxHttp<GetTransaction, HistoricTransaction, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/history/get_transaction",
                method: "POST",
                body: body
            )
        )
    }

    func getKeyAccounts(body: GetKeyAccounts) -> Single<HttpResponse<Accounts>> {
        return RxHttp<GetKeyAccounts, Accounts, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/history/get_key_accounts",
                method: "POST",
                body: body
            )
        )
    }

    func getControlledAccounts(body: GetControlledAccounts) -> Single<HttpResponse<Accounts>> {
        return RxHttp<GetControlledAccounts, Accounts, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/history/get_controlled_accounts",
                method: "POST",
                body: body
            )
        )
    }
}

public class HistoryApiFactory {
    public static func create(
        rootUrl: String,
        urlSession: URLSession = URLSession.shared,
        useLogger: Bool = false
    ) -> HistoryApi {
        return HistoryApiImpl(rootUrl: rootUrl, urlSession: urlSession, useLogger: useLogger)
    }
}

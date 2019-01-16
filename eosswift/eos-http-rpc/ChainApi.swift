import Foundation
import RxSwift

public protocol ChainApi {

    func getInfo() -> Single<HttpResponse<Info>>

    func getProducers(body: GetProducers) -> Single<HttpResponse<ProducerList>>

    func getBlock(body: BlockNumOrId) -> Single<HttpResponse<Block>>

    func getBlockHeaderState(body: BlockNumOrId) -> Single<HttpResponse<BlockHeaderState>>

    func getAccount(body: AccountName) -> Single<HttpResponse<Account>>

    func getAbi(body: AccountName) -> Single<HttpResponse<AbiForAccount>>

    func getCode(body: GetCodeByAccountName) -> Single<HttpResponse<CodeForAccount>>

    func getRawCodeAndAbi(body: AccountName) -> Single<HttpResponse<RawCodeForAccount>>

    func getTableRows(body: GetTableRows) -> Single<HttpResponse<ContractTableRows>>

    func getCurrencyBalance(body: GetCurrencyBalance) -> Single<HttpResponse<Array<String>>>

    func abiJsonToBin(body: RequestBody) -> Single<HttpResponse<BinaryHex>>

    func abiBinToJson(body: AbiBinToJson) -> Single<HttpResponse<ResponseBody>>

    func getRequiredKeys(body: GetRequiredKeysBody) -> Single<HttpResponse<RequiredKeys>>

    func getCurrencyStats(body: GetCurrencyStats) -> Single<HttpResponse<ResponseBody>>

    func pushTransaction(body: PushTransaction) -> Single<HttpResponse<TransactionCommitted>>
}

class ChainApiImpl : ChainApi {

    private let rootUrl: String
    private let urlSession: URLSession
    private let useLogger: Bool

    fileprivate init(rootUrl: String, urlSession: URLSession, useLogger: Bool) {
        self.rootUrl = rootUrl
        self.urlSession = urlSession
        self.useLogger = useLogger
    }

    func getInfo() -> Single<HttpResponse<Info>> {
        return RxHttp<RequestBody, Info, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/get_info",
                method: "GET",
                body: nil
            )
        )
    }

    func getProducers(body: GetProducers) -> Single<HttpResponse<ProducerList>> {
        return RxHttp<GetProducers, ProducerList, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/get_producers",
                method: "POST",
                body: body
            )
        )
    }

    func getBlock(body: BlockNumOrId) -> Single<HttpResponse<Block>> {
        return RxHttp<BlockNumOrId, Block, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/get_block",
                method: "POST",
                body: body
            )
        )
    }

    func getBlockHeaderState(body: BlockNumOrId) -> Single<HttpResponse<BlockHeaderState>> {
        return RxHttp<BlockNumOrId, BlockHeaderState, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/get_block_header_state",
                method: "POST",
                body: body
            )
        )
    }

    func getAccount(body: AccountName) -> Single<HttpResponse<Account>> {
        return RxHttp<AccountName, Account, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/get_account",
                method: "POST",
                body: body
            )
        )
    }

    func getAbi(body: AccountName) -> Single<HttpResponse<AbiForAccount>> {
        return RxHttp<AccountName, AbiForAccount, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/get_abi",
                method: "POST",
                body: body
            )
        )
    }

    func getCode(body: GetCodeByAccountName) -> Single<HttpResponse<CodeForAccount>> {
        return RxHttp<GetCodeByAccountName, CodeForAccount, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/get_code",
                method: "POST",
                body: body
            )
        )
    }

    func getRawCodeAndAbi(body: AccountName) -> Single<HttpResponse<RawCodeForAccount>> {
        return RxHttp<AccountName, RawCodeForAccount, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/get_raw_code_and_abi",
                method: "POST",
                body: body
            )
        )
    }

    func getTableRows(body: GetTableRows) -> Single<HttpResponse<ContractTableRows>> {
        return RxHttp<GetTableRows, ContractTableRows, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/get_table_rows",
                method: "POST",
                body: body
            )
        )
    }

    func getCurrencyBalance(body: GetCurrencyBalance) -> Single<HttpResponse<Array<String>>> {
        return RxHttp<GetCurrencyBalance, Array<String>, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/get_currency_balance",
                method: "POST",
                body: body
            )
        )
    }

    func abiJsonToBin(body: RequestBody) -> Single<HttpResponse<BinaryHex>> {
        fatalError("The local abi byte writing should be used in replace of this call. Mobile clients that use this method are exposed to man in the middle attacks.")
    }

    func abiBinToJson(body: AbiBinToJson) -> Single<HttpResponse<ResponseBody>> {
        return RxHttp<AbiBinToJson, ResponseBody, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/abi_bin_to_json",
                method: "POST",
                body: body
            )
        )
    }

    func getRequiredKeys(body: GetRequiredKeysBody) -> Single<HttpResponse<RequiredKeys>> {
        return RxHttp<GetRequiredKeysBody, RequiredKeys, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/get_required_keys",
                method: "POST",
                body: body
            )
        )
    }

    func getCurrencyStats(body: GetCurrencyStats) -> Single<HttpResponse<ResponseBody>> {
        return RxHttp<GetCurrencyStats, ResponseBody, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/get_currency_stats",
                method: "POST",
                body: body
            )
        )
    }

    func pushTransaction(body: PushTransaction) -> Single<HttpResponse<TransactionCommitted>> {
        return RxHttp<PushTransaction, TransactionCommitted, ChainError>(urlSession, useLogger).single(
            httpRequest: HttpRequest(
                url: self.rootUrl + "v1/chain/push_transaction",
                method: "POST",
                body: body
            )
        )
    }
}

public class ChainApiFactory {
    public static func create(rootUrl: String, urlSession: URLSession = URLSession.shared, useLogger: Bool = false) -> ChainApi {
        return ChainApiImpl(rootUrl: rootUrl, urlSession: urlSession, useLogger: useLogger)
    }
}

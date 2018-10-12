import Foundation
import RxSwift

protocol ChainApi {

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

    func getInfo() -> Single<HttpResponse<Info>> {
        fatalError()
    }

    func getProducers(body: GetProducers) -> Single<HttpResponse<ProducerList>> {
        fatalError()
    }

    func getBlock(body: BlockNumOrId) -> Single<HttpResponse<Block>> {
        fatalError()
    }

    func getBlockHeaderState(body: BlockNumOrId) -> Single<HttpResponse<BlockHeaderState>> {
        fatalError()
    }

    func getAccount(body: AccountName) -> Single<HttpResponse<Account>> {
        fatalError()
    }

    func getAbi(body: AccountName) -> Single<HttpResponse<AbiForAccount>> {
        fatalError()
    }

    func getCode(body: GetCodeByAccountName) -> Single<HttpResponse<CodeForAccount>> {
        fatalError()
    }

    func getRawCodeAndAbi(body: AccountName) -> Single<HttpResponse<RawCodeForAccount>> {
        fatalError()
    }

    func getTableRows(body: GetTableRows) -> Single<HttpResponse<ContractTableRows>> {
        fatalError()
    }

    func getCurrencyBalance(body: GetCurrencyBalance) -> Single<HttpResponse<Array<String>>> {
        fatalError()
    }

    func abiJsonToBin(body: RequestBody) -> Single<HttpResponse<BinaryHex>> {
        fatalError()
    }

    func abiBinToJson(body: AbiBinToJson) -> Single<HttpResponse<ResponseBody>> {
        fatalError()
    }

    func getRequiredKeys(body: GetRequiredKeysBody) -> Single<HttpResponse<RequiredKeys>> {
        fatalError()
    }

    func getCurrencyStats(body: GetCurrencyStats) -> Single<HttpResponse<ResponseBody>> {
        fatalError()
    }

    func pushTransaction(body: PushTransaction) -> Single<HttpResponse<TransactionCommitted>> {
        fatalError()
    }
}

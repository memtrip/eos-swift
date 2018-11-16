import Foundation
import RxSwift

public class GetRegProxyInfo {

    private let chainApi: ChainApi

    public init(chainApi: ChainApi) {
        self.chainApi = chainApi
    }

    public func getProxies(limit: Int, nextAccount: String = "") -> Single<[ProxyJson]> {
        return chainApi.getTableRows(body: GetTableRows(
            scope: "regproxyinfo",
            code: "regproxyinfo",
            table: "proxies",
            table_key: "",
            json: true,
            limit: limit,
            lower_bound: next(nextAccount: nextAccount, offset: 1),
            upper_bound: "",
            key_type: "",
            index_position: "",
            encode_type: "dec"
        )).map { response in
            if (response.success) {
                return response.body!.rows.map { row in
                    return ProxyJson(
                        owner: row["owner"]!.jsonValue as! String,
                        name: row["name"]!.jsonValue as! String,
                        website: row["website"]!.jsonValue as! String,
                        slogan: row["slogan"]!.jsonValue as! String,
                        philosophy: row["philosophy"]!.jsonValue as! String,
                        background: row["background"]!.jsonValue as! String,
                        logo_256: row["logo_256"]!.jsonValue as! String,
                        telegram: row["telegram"]!.jsonValue as! String,
                        steemit: row["steemit"]!.jsonValue as! String,
                        twitter: row["twitter"]!.jsonValue as! String,
                        wechat: row["wechat"]!.jsonValue as! String
                    )
                }
            } else {
                throw FetchProxyError.failed()
            }
        }
    }

    public func getProxy(accountName: String = "") -> Single<ProxyJson> {
        return chainApi.getTableRows(body: GetTableRows(
            scope: "regproxyinfo",
            code: "regproxyinfo",
            table: "proxies",
            table_key: "",
            json: true,
            limit: 1,
            lower_bound: next(nextAccount: accountName),
            upper_bound: next(nextAccount: accountName, offset: 1),
            key_type: "",
            index_position: "",
            encode_type: "dec"
        )).map { response in
            if (response.success) {
                let row = response.body!.rows[0]
                return ProxyJson(
                    owner: row["owner"]!.jsonValue as! String,
                    name: row["name"]!.jsonValue as! String,
                    website: row["website"]!.jsonValue as! String,
                    slogan: row["slogan"]!.jsonValue as! String,
                    philosophy: row["philosophy"]!.jsonValue as! String,
                    background: row["background"]!.jsonValue as! String,
                    logo_256: row["logo_256"]!.jsonValue as! String,
                    telegram: row["telegram"]!.jsonValue as! String,
                    steemit: row["steemit"]!.jsonValue as! String,
                    twitter: row["twitter"]!.jsonValue as! String,
                    wechat: row["wechat"]!.jsonValue as! String
                )
            } else {
                throw FetchProxyError.failed()
            }
        }
    }

    private func next(nextAccount: String, offset: Int = 0) -> String {
        if (nextAccount.count == 0) {
            return ""
        } else {
            return String(NameWriterValue(name: nextAccount).nameAsInt64(name: nextAccount) + Int64.init(offset))
        }
    }
}

public enum FetchProxyError : Error {
    case failed()
}

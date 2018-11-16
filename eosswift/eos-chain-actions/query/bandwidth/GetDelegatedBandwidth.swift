import Foundation
import RxSwift

public class GetDelegatedBandwidth {

    private let chainApi: ChainApi

    public init(chainApi: ChainApi) {
        self.chainApi = chainApi
    }

    public func getBandwidth(accountName: String) -> Single<[BandwidthJson]> {
        return chainApi.getTableRows(body: GetTableRows(
            scope: accountName,
            code: "eosio",
            table: "delband",
            table_key: "",
            json: true,
            limit: 100,
            lower_bound: "",
            upper_bound: "",
            key_type: "",
            index_position: "",
            encode_type: "dec"
        )).map { response in
            if (response.success) {
                let rows = response.body!.rows
                return rows.map { row in
                    BandwidthJson(
                        from: row["from"]!.jsonValue as! String,
                        to: row["to"]!.jsonValue as! String,
                        net_weight: row["net_weight"]!.jsonValue as! String,
                        cpu_weight: row["cpu_weight"]!.jsonValue as! String
                    )
                }
            } else {
                throw FailedToFetchDelegatedBandwidth.generic()
            }
        }
    }
}

public enum FailedToFetchDelegatedBandwidth : Error {
    case generic()
}

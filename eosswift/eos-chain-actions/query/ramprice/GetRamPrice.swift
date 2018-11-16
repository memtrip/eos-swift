import Foundation
import RxSwift
import BigInt

public class GetRamPrice {

    private let chainApi: ChainApi

    public init(chainApi: ChainApi) {
        self.chainApi = chainApi
    }

    public func getPricePerKilobyte() -> Single<Double> {
        return chainApi.getTableRows(body: GetTableRows(
            scope: "eosio",
            code: "eosio",
            table: "rammarket",
            table_key: "",
            json: true,
            limit: 1,
            lower_bound: "",
            upper_bound: "",
            key_type: "",
            index_position: "",
            encode_type: "dec"
        )).map { response in
            if (response.success) {
                let rows = response.body!.rows
                if (rows.count > 0) {
                    return self.calculateRamPerKiloByte(row: rows[0])
                } else {
                    throw GetRamPriceError.failed()
                }
            } else {
                throw GetRamPriceError.failed()
            }
        }
    }

    private func calculateRamPerKiloByte(row: [String:AnyJSONType]) -> Double {
        let quote = row["quote"]!.jsonValue as! [String:AnyJSONType]
        let base = row["base"]!.jsonValue as! [String:AnyJSONType]
        let quoteBalance = value(balance: quote["balance"]!.jsonValue as! String)
        let baseBalance = value(balance: base["balance"]!.jsonValue as! String)

        return (quoteBalance / baseBalance) * 1024
    }

    private func value(balance: String) -> Double {
        let split = String(balance.split(separator: " ")[0])
        return Double(split)!
    }
}

public enum GetRamPriceError : Error {
    case failed()
}

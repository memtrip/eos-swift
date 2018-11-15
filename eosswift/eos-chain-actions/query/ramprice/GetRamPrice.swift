import Foundation
import RxSwift
import BigInt

class GetRamPrice {

    private let chainApi: ChainApi

    public init(chainApi: ChainApi) {
        self.chainApi = chainApi
    }

    func getPricePerKilobyte() -> Single<Double> {
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
                    throw GetRamPrice.failed()
                }
            } else {
                throw GetRamPrice.failed()
            }
        }
    }

    private func calculateRamPerKiloByte(row: [String:AnyJSONType]) -> Double {
        let quote = row["quote"]!.jsonValue as! [String:String]
        let base = row["base"]!.jsonValue as! [String:String]
        let quoteBalance = value(balance: quote["balance"]!)
        let baseBalance = value(balance: base["balance"]!)

        return (Double(quoteBalance) / Double(baseBalance)) * 1024
    }

    private func value(balance: String) -> BigInt {
        let split = balance.split(separator: " ")[0]
        return BigInt(split)!
    }

    enum GetRamPrice : Error {
        case failed()
    }
}

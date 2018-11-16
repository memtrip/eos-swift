import Foundation
import RxSwift

public class GetBlockProducers {

    private let chainApi: ChainApi
    private let decode = JSONDecoder()

    public init(chainApi: ChainApi) {
        self.chainApi = chainApi
    }

    public func getSingleProducer(accountName: String) -> Single<BlockProducer> {
         let primaryKey = NameWriterValue(name: accountName).nameAsInt64(name: accountName)
        return getBpJson(limit: 1, lowerBound: String(primaryKey), upperBound: String(primaryKey+1)).map { bps in
            if (bps.count > 0) {
                let apiEndpoint = self.findApiEndPointInNodes(nodes: bps[0].nodes)
                if (apiEndpoint != nil) {
                    return BlockProducer(
                        bpJson: bps[0],
                        apiEndpoint: apiEndpoint!
                    )
                } else {
                    throw GetBlockProducerError.chainProducerJsonMissing()
                }
            } else {
                throw GetBlockProducerError.chainProducerJsonMissing()
            }
        }
    }

    public func getProducers(limit: Int) -> Single<[BlockProducer]> {
        return getBpJson(limit: limit, lowerBound: "", upperBound: "").flatMap { blockProducersContract in
            return self.chainApi.getProducers(body: GetProducers(
                json: true,
                lower_bound: "",
                limit: limit
            )).map { response in
                if (response.success) {
                    let rows = response.body!.rows
                    return rows.compactMap { producer in
                        let bpJson = blockProducersContract.first(where: { bpParent in
                            return producer.is_active == 1 && bpParent.producer_account_name == producer.owner
                        })

                        if (bpJson != nil) {
                            let apiEndpoint = self.findApiEndPointInNodes(nodes: bpJson!.nodes)
                            if (apiEndpoint != nil) {
                                return BlockProducer(
                                    bpJson: bpJson!,
                                    apiEndpoint: apiEndpoint!)
                            } else {
                                return nil
                            }
                        } else {
                            return nil
                        }
                    }
                } else {
                    throw GetBlockProducerError.failedToFetchBlockProducer
                }
            }
        }
    }

    private func getBpJson(
        limit: Int,
        lowerBound: String,
        upperBound: String
    ) -> Single<[BpParent]> {
        return chainApi.getTableRows(body: GetTableRows(
            scope: "producerjson",
            code: "producerjson",
            table: "producerjson",
            table_key: "",
            json: true,
            limit: limit,
            lower_bound: lowerBound,
            upper_bound: upperBound,
            key_type: "",
            index_position: "",
            encode_type: "dec")
        ).map { response in
            if (response.success) {
                return response.body!.rows.compactMap { row in
                    return try? self.decode.decode(BpParent.self, from: (row["json"]!.jsonValue as! String).data(using: .utf8)!)
                }
            } else {
                throw GetBlockProducerError.failedToFetchBlockProducer
            }
        }
    }

    private func findApiEndPointInNodes(nodes: [BpNode]) -> String? {
        let firstNodeWithSSLEndpoint = nodes.first(where: { node in
            return node.ssl_endpoint != nil && node.ssl_endpoint!.count > 0
        })

        if (firstNodeWithSSLEndpoint != nil) {
            return firstNodeWithSSLEndpoint!.ssl_endpoint
        } else {
            return nodes.first(where: { node in
                return node.api_endpoint != nil && node.api_endpoint!.count > 0
            })?.api_endpoint
        }
    }
}

public enum GetBlockProducerError : Error {
    case chainProducerJsonMissing()
    case failedToFetchBlockProducer
}

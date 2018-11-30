import Foundation
import RxSwift

public protocol ChainTransaction {
    func chainApi() -> ChainApi
}

public extension ChainTransaction {
    public func push(
        expirationDate: Date,
        actions: [ActionAbi],
        authorizingPrivateKey: EOSPrivateKey
    ) -> Single<ChainResponse<TransactionCommitted>> {
        return chainApi().getInfo().flatMap { info in
            if (info.success) {
                let transactionAbi = self.createTransactionAbi(
                    expirationDate: expirationDate,
                    blockIdDetails: BlockIdDetails(blockId: info.body!.head_block_id),
                    actions: actions)

                let signedTransactionAbi = SignedTransactionAbi(
                    chainId: ChainIdWriterValue(chainId: info.body!.chain_id),
                    transaction: transactionAbi,
                    context_free_data: HexCollectionWriterValue(value: []))

                let signature = PrivateKeySigning().sign(
                    digest: signedTransactionAbi.toData(),
                    eosPrivateKey: authorizingPrivateKey)

                return self.chainApi().pushTransaction(body: PushTransaction(
                    signatures: [signature],
                    compression: "none",
                    packed_context_free_data: "",
                    packed_trx: transactionAbi.toHex()
                )).map { response in
                    ChainResponse<TransactionCommitted>(
                        success: response.success,
                        statusCode: response.statusCode,
                        body: response.body)
                }.catchError { error in
                    let errorResponse = (error as! HttpErrorResponse<ChainError>)
                    return Single.just(ChainResponse<TransactionCommitted>(
                        success: false,
                        statusCode: errorResponse.statusCode,
                        errorBody: errorResponse.bodyString!))
                }.catchErrorJustReturn(ChainResponse.errorResponse())
            } else {
                return Single.just(ChainResponse.errorResponse())
            }
        }
    }

    private func createTransactionAbi(expirationDate: Date,
                             blockIdDetails: BlockIdDetails,
                             actions: Array<ActionAbi>) -> TransactionAbi {
        return TransactionAbi(
            expiration: TimestampWriterValue(date: expirationDate),
            ref_block_num: BlockNumWriterValue(value: blockIdDetails.blockNum),
            ref_block_prefix: BlockPrefixWriterValue(value: blockIdDetails.blockPrefix),
            max_net_usage_words: 0,
            max_cpu_usage_ms: 0,
            delay_sec: 0,
            context_free_actions: [],
            actions: actions,
            transaction_extensions: StringCollectionWriterValue(value: []))
    }
}

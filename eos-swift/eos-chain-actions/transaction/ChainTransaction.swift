import Foundation
import RxSwift

protocol ChainTransaction {
    func chainApi() -> ChainApi
}

extension ChainTransaction {
    func push(
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
                    digest: try self.encodeSignedTransactionAbi(signedTransactionAbi: signedTransactionAbi),
                    eosPrivateKey: authorizingPrivateKey)

                return self.chainApi().pushTransaction(body: PushTransaction(
                    signatures: [signature],
                    compression: "none",
                    packed_context_free_data: "",
                    packed_trx: try self.encodeTransactionAbi(transactionAbi: transactionAbi).hexEncodedString()
                )).map { response in
                    ChainResponse<TransactionCommitted>(
                        success: response.success,
                        statusCode: response.statusCode,
                        body: response.body,
                        errorBody: nil)
                }.catchErrorJustReturn(ChainResponse.errorResponse())
            } else {
                return Single.just(ChainResponse.errorResponse())
            }
        }
    }

    private func encodeSignedTransactionAbi(signedTransactionAbi: SignedTransactionAbi) throws -> Data {
        let abiEncoder = AbiEncoder(capacity: 512)
        try abiEncoder.encode(encodable: signedTransactionAbi)
        return abiEncoder.toData()
    }

    private func encodeTransactionAbi(transactionAbi: TransactionAbi) throws -> Data {
        let abiEncoder = AbiEncoder(capacity: 512)
        try abiEncoder.encode(encodable: transactionAbi)
        return abiEncoder.toData()
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
            transaction_extensions: StringCollectionWriterValue(value: []),
            signatures: StringCollectionWriterValue(value: []),
            context_free_data: StringCollectionWriterValue(value: []))
    }
}

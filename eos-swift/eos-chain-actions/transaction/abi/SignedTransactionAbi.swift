import Foundation

struct SignedTransactionAbi : Encodable {
    let chainId: ChainIdWriterValue
    let transaction: TransactionAbi
    let context_free_data: HexCollectionWriterValue
}

import Foundation

public struct SignedTransactionAbi : Encodable {
    public let chainId: ChainIdWriterValue
    public let transaction: TransactionAbi
    public let context_free_data: HexCollectionWriterValue

    public init(chainId: ChainIdWriterValue, transaction: TransactionAbi, context_free_data: HexCollectionWriterValue) {
        self.chainId = chainId
        self.transaction = transaction
        self.context_free_data = context_free_data
    }
}

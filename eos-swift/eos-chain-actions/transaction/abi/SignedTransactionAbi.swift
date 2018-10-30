import Foundation

struct SignedTransactionAbi {
    let chainId: String
    let transaction: TransactionAbi
    let context_free_data: [String]
}

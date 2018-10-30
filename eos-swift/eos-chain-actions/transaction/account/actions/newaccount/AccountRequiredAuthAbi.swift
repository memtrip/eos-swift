import Foundation

struct AccountRequiredAuthAbi : Encodable {
    let threshold: Int32
    let keys: [AccountKeyAbi]
    let accounts: StringCollectionWriterValue
    let waits: StringCollectionWriterValue
}

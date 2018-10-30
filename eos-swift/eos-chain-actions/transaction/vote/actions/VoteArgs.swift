import Foundation

struct VoteArgs : Encodable {
    let voter: AccountNameWriterValue
    let proxy: AccountNameWriterValue
    let producers: AccountNameCollectionWriterValue
}

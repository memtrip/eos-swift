import Foundation

struct NewAccountArgs : Encodable {
    let creator: AccountNameWriterValue
    let name: AccountNameWriterValue
    let owner: AccountRequiredAuthAbi
    let active: AccountRequiredAuthAbi
}

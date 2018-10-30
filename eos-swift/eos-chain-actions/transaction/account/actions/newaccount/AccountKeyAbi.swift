import Foundation

struct AccountKeyAbi : Encodable {
    let key: PublicKeyWriterValue
    let weight: Int32
}

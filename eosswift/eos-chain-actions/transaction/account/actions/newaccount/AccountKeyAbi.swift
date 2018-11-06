import Foundation

public struct AccountKeyAbi : Encodable {
    public let key: PublicKeyWriterValue
    public let weight: Int16

    public init(key: PublicKeyWriterValue, weight: Int16) {
        self.key = key
        self.weight = weight
    }
}

import Foundation
import CommonCrypto

class Sha256Hash {

    static func hash(data : Data) -> Data {

        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(data.count), &hash)
        }
        return Data(bytes: hash)
    }

    static func hashTwice(data: Data) -> Data {
        return hash(data: hash(data: data))
    }
}

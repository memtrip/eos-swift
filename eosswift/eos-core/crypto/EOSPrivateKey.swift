import Foundation
import BigInt

public class EOSPrivateKey {

    private let ecKeyPrivateKey: ECPrivateKey
    
    public let publicKey: EOSPublicKey
    public let base58: String

    public init() throws {
        ecKeyPrivateKey = ECPrivateKey()
        base58 = EOSPrivateKey.base58Encode(key: ecKeyPrivateKey)
        publicKey = EOSPublicKey(bytes: ecKeyPrivateKey.pubKeyData)
    }

    public init(ecKeyPrivateKey: ECPrivateKey) {
        self.ecKeyPrivateKey = ecKeyPrivateKey
        base58 = EOSPrivateKey.base58Encode(key: ecKeyPrivateKey)
        publicKey = EOSPublicKey(bytes: ecKeyPrivateKey.pubKeyData)
    }

    public init(base58: String) throws {
        ecKeyPrivateKey = ECPrivateKey(privKeyData: try EOSPrivateKey.getPrivateKeyFromBase58Bytes(base58: base58))
        self.base58 = base58
        publicKey = EOSPublicKey(bytes: ecKeyPrivateKey.pubKeyData)
    }

    public func bytes() -> Data {
        return ecKeyPrivateKey.privKeyData
    }

    public func bigInt() -> BigUInt {
        return BigUInt(bytes())
    }

    private static func getPrivateKeyFromBase58Bytes(base58: String) throws -> Data {
        if (base58.split(separator: "_").count == 1) {
            let base58Bytes = Data(base58Decoding: base58)!
            if (base58Bytes.count > 4) {
                let checkSumBytes = base58Bytes.subdata(in: 0..<base58Bytes.count-4)

                let checkOne = Sha256Hash.hash(data: checkSumBytes)
                let checkTwo = Sha256Hash.hash(data: checkOne)
                if (equalsFromOffset(hashBytes: checkTwo, toCompareData: base58Bytes, offset: base58Bytes.count - 4) ||
                    equalsFromOffset(hashBytes: checkOne, toCompareData: base58Bytes, offset: base58Bytes.count - 4)) {
                    let keyBytes = base58Bytes.subdata(in: 1..<base58Bytes.count-4)
                    if (keyBytes.count < 5) {
                        throw InvalidPrivateKeyFormat.invalidLength("Invalid private key length.")
                    }
                    return keyBytes
                } else {
                    throw InvalidPrivateKeyFormat.checksum("Invalid private key format, not expecting a prefix")
                }
            } else {
                throw InvalidPrivateKeyFormat.invalidLength("Invalid private key length.")
            }
        } else {
            throw InvalidPrivateKeyFormat.prefixNotExpected("Invalid private key format, not expecting a prefix")
        }
    }

    private static func equalsFromOffset(hashBytes: Data, toCompareData: Data, offset: Int) -> Bool {
        if (offset < 0 || hashBytes.count <= 4 || toCompareData.count <= offset) {
            return false
        }

        for index in 0...3 {
            if (hashBytes[index] != toCompareData[offset + index]) {
                return false
            }
        }

        return true
    }

    private static func base58Encode(key: ECPrivateKey) -> String {
        let privateKeyBytes = key.privKeyData
        var resultBytes = Data(Array<UInt8>(repeating: 0, count: 1 + 32 + 4))
        resultBytes[0] = UInt8(0x80)
        let startingPosition = (privateKeyBytes.count > 32) ? 1 : 0
        resultBytes[1..<32] = privateKeyBytes[startingPosition..<32]
        let checksum = Sha256Hash.hashTwice(data: resultBytes.subdata(in: 0..<33))
        resultBytes[33..<resultBytes.count] = checksum[0..<4]
        return String(base58Encoding: resultBytes)
    }

    enum InvalidPrivateKeyFormat: Error {
        case invalidLength(String)
        case checksum(String)
        case prefixNotExpected(String)
    }
}

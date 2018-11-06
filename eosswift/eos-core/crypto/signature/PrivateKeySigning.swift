import Foundation
import microecc

public class PrivateKeySigning {

    public init() {
    }

    public func sign(digest: Data, eosPrivateKey: EOSPrivateKey) -> String {
        let hashDigest = Sha256Hash.hash(data: digest).toUInt8Array()
        let privateKeyBytes = eosPrivateKey.bytes().toUInt8Array()
        let signatureResult = UnsafeMutablePointer<UInt8>.allocate(capacity: 64)

        let recId = uECC_sign_forbc(
            privateKeyBytes,
            hashDigest,
            UInt32.init(hashDigest.count),
            signatureResult,
            uECC_secp256k1()
        )

        var signatureBytes: [UInt8] = [UInt8](UnsafeBufferPointer(start: signatureResult, count: 64))

        let headerByte = recId + 27 + 4
        let headerByteArray: [UInt8] = [UInt8.init(headerByte)]
        var resultBytes = [UInt8](repeating: 0, count: 65)
        resultBytes[0..<1] = headerByteArray[0..<1]
        resultBytes[1..<resultBytes.count] = signatureBytes[0..<signatureBytes.count]

        return Base58.encodeWithChecksum(prefix: "SIG", signaturePrefix: "K1", data: Data(bytes: resultBytes))
    }
}

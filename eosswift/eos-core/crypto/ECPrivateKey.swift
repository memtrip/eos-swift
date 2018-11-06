import Foundation
import microecc

public class ECPrivateKey {

    let privKeyData: Data
    let pubKeyData: Data

    public init() {
        privKeyData = ECPrivateKey.generatePrivateKeyBytes()
        pubKeyData = ECPrivateKey.resolvePubKeyBytesFromPrivKey(privKeyData: privKeyData)
    }

    public init(privKeyData: Data) {
        self.privKeyData = privKeyData
        self.pubKeyData = ECPrivateKey.resolvePubKeyBytesFromPrivKey(privKeyData: privKeyData)
    }

    private static func generatePrivateKeyBytes() -> Data {

        // Check if vch is greater than or equal to max value
        func check(_ vch: [UInt8]) -> Bool {
            let max: [UInt8] = [
                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
                0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE,
                0xBA, 0xAE, 0xDC, 0xE6, 0xAF, 0x48, 0xA0, 0x3B,
                0xBF, 0xD2, 0x5E, 0x8C, 0xD0, 0x36, 0x41, 0x40
            ]
            var fIsZero = true
            for byte in vch where byte != 0 {
                fIsZero = false
                break
            }
            if fIsZero {
                return false
            }
            for (index, byte) in vch.enumerated() {
                if byte < max[index] {
                    return true
                }
                if byte > max[index] {
                    return false
                }
            }
            return true
        }

        let count = 32
        var key = Data(count: count)
        var status: Int32 = 0
        repeat {
            status = key.withUnsafeMutableBytes { SecRandomCopyBytes(kSecRandomDefault, count, $0) }
        } while (status != 0 || !check([UInt8](key)))

        return key
    }

    private static func resolvePubKeyBytesFromPrivKey(privKeyData: Data) -> Data {
        var publicBytes: Array<UInt8> = Array(repeating: UInt8(0), count: 64)
        var compressedPublicBytes: Array<UInt8> = Array(repeating: UInt8(0), count: 33)
        let curve: uECC_Curve = uECC_secp256k1()
        uECC_compute_public_key([UInt8](privKeyData), &publicBytes, curve)
        uECC_compress(&publicBytes, &compressedPublicBytes, curve)
        return Data(bytes: compressedPublicBytes, count: 33)
    }
}

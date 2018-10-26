import Foundation

class ECPublicKey {

    let pubKeyData: Data

    init(pubKeyData: Data) {
        self.pubKeyData = ECPublicKey.resolvePubKeyBytes(pubKeyData: pubKeyData)
    }

    private static func resolvePubKeyBytes(pubKeyData: Data) -> Data {
        let decompressedPublicBytes = [UInt8](pubKeyData)
        var publicBytes: Array<UInt8> = Array(repeating: UInt8(0), count: 64)
        let curve: uECC_Curve = uECC_secp256k1()
        uECC_decompress(decompressedPublicBytes, &publicBytes, curve)
        return Data(bytes: decompressedPublicBytes, count: 33)
    }
}

import Foundation

class EOSPublicKey {

    private let ecPublicKey: ECPublicKey
    let base58: String

    func bytes() -> Data {
        return ecPublicKey.pubKeyData
    }

    init(bytes: Data) {
        self.ecPublicKey = ECPublicKey(pubKeyData: bytes)
        self.base58 = Base58.encodeWithChecksum(prefix: "EOS", data: ecPublicKey.pubKeyData)
    }

    init(base58: String) throws {
        self.ecPublicKey = ECPublicKey(pubKeyData: try EOSPublicKey.bytesFromBase58(base58: base58))
        self.base58 = base58
    }

    private static func bytesFromBase58(base58: String) throws -> Data {
        let parts = base58.split {$0 == "_"}
        if (parts.count == 1) {
            return Base58.decodeWithChecksum(base58: base58[3...base58.count-1])
        } else {
            throw AddressFormatException.unsupportFormat()
        }
    }

    enum AddressFormatException: Error, Equatable {
        case unsupportFormat()

        static func ==(lhs: AddressFormatException, rhs: AddressFormatException) -> Bool {
            switch (lhs, rhs) {
            case (.unsupportFormat, .unsupportFormat):
                return true
            }
        }
    }
}

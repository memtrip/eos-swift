import Foundation

public class EOSPublicKey {

    private let pubKeyData: Data
    
    public let base58: String

    public func bytes() -> Data {
        return pubKeyData
    }

    public init(bytes: Data) {
        self.pubKeyData = bytes
        self.base58 = Base58.encodeWithChecksum(prefix: "EOS", data: pubKeyData)
    }

    public init(base58: String) throws {
        self.pubKeyData = try EOSPublicKey.bytesFromBase58(base58: base58)
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

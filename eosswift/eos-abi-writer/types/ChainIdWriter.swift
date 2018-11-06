import Foundation

protocol ChainIdWriter : AbiTypeWriter {
}

public class ChainIdWriterValue : ChainIdWriter, Encodable {

    private let chainId: String

    public init(chainId: String) {
        self.chainId = chainId
    }

    func encode(writer: AbiEncodingContainer) throws {
       try writer.encodeBytes(value: getSha256FromHexStr(value: chainId))
    }

    private func getSha256FromHexStr(value: String) -> Array<UInt8> {
        let len = value.count
        var bytes = Array<UInt8>(repeating: 0, count: 32)
    var i = 0
        while (i < len) {
            let str = value[i...i+1]
            bytes[i / 2] = UInt8.init(String(str), radix: 16)! & 0xFF
            i += 2
        }
        return bytes
    }
}

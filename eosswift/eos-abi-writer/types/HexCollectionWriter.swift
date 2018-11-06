import Foundation

protocol HexCollectionWriter : AbiTypeWriter {
}

public class HexCollectionWriterValue : HexCollectionWriter, Encodable {

    private let value: Array<String>

    public init(value: Array<String>) {
        self.value = value
    }

    func encode(writer: AbiEncodingContainer) throws {
        try writer.encodeBytes(value: hexCollectionBytes(hexList: self.value))
    }

    private func hexCollectionBytes(hexList: [String]) -> [UInt8] {
        if (hexList.count == 0) {
            return [UInt8](Data(repeating: 0, count: 32))
        } else {
            fatalError("not implemented")
        }
    }
}

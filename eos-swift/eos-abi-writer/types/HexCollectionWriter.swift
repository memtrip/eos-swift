import Foundation

protocol HexCollectionWriter : AbiTypeWriter {
}

class HexCollectionWriterValue : HexCollectionWriter, Encodable {

    private let value: Array<String>

    init(value: Array<String>) {
        self.value = value
    }

    func encode(writer: AbiEncodingContainer) throws {
        // TODO - requires a SHA256 implementation
    }
}

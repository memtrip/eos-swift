import Foundation

protocol HexCollectionWriter : AbiTypeWriter, Encodable {
}

class HexCollectionWriterValue : HexCollectionWriter {

    private let value: Array<String>

    init(value: Array<String>) {
        self.value = value
    }

    func encode(writer: AbiEncodingContainer) throws {
    }
}

import Foundation

protocol StringCollectionWriter : AbiTypeWriter, Encodable {
}

class StringCollectionWriterValue : StringCollectionWriter {

    private let value: Array<String>

    init(value: Array<String>) {
        self.value = value
    }

    func encode(writer: AbiEncodingContainer) throws {
    }
}

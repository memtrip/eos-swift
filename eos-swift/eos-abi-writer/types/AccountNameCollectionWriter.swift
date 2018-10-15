import Foundation

protocol AccountNameCollectionWriter : AbiTypeWriter, Encodable {
}

class AccountNameCollectionWriterValue : AccountNameCollectionWriter {

    private let value: Array<String>

    init(value: Array<String>) {
        self.value = value
    }

    func encode(writer: AbiEncodingContainer) throws {
    }
}

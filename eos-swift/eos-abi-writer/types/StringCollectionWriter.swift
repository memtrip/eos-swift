import Foundation

protocol StringCollectionWriter : AbiTypeWriter, Encodable {
}

class StringCollectionWriterValue : StringCollectionWriter {

    private let value: Array<String>

    init(value: Array<String>) {
        self.value = value
    }

    func encode(writer: AbiEncodingContainer) throws {
        try writer.encode(UInt64.init(value.count))

        if (value.count > 0) {
            try value.forEach {
                try writer.encode($0)
            }
        }
    }
}

import Foundation

protocol StringCollectionWriter : AbiTypeWriter {
}

public class StringCollectionWriterValue : StringCollectionWriter, Encodable {

    private let value: Array<String>

    public init(value: Array<String>) {
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

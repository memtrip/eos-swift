import Foundation

protocol BlockPrefixWriter : AbiTypeWriter, Encodable {
}

class BlockPrefixWriterValue : BlockPrefixWriter {

    private let value: Int64

    init(value: Int64) {
        self.value = value
    }

    func encode(writer: AbiEncodingContainer) throws {
        try writer.encode(Int64.init(value & -0x1))
    }
}

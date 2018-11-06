import Foundation

protocol BlockPrefixWriter : AbiTypeWriter {
}

public class BlockPrefixWriterValue : BlockPrefixWriter, Encodable {

    private let value: Int64

    public init(value: Int64) {
        self.value = value
    }

    func encode(writer: AbiEncodingContainer) throws {
        try writer.encode(Int32(truncatingIfNeeded: value & -0x1))
    }
}

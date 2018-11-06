import Foundation

protocol BlockNumWriter : AbiTypeWriter {
}

public class BlockNumWriterValue : BlockNumWriter, Encodable {

    private let value: Int

    public init(value: Int) {
        self.value = value
    }

    func encode(writer: AbiEncodingContainer) throws {
        try writer.encode(Int16(truncatingIfNeeded: value & 0xFFFF))
    }
}

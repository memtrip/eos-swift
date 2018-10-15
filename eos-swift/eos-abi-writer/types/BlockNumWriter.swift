import Foundation

protocol BlockNumWriter : AbiTypeWriter, Encodable {
}

class BlockNumWriterValue : BlockNumWriter {

    private let value: Int16

    init(value: Int16) {
        self.value = value
    }

    func encode(writer: AbiEncodingContainer) throws {
        try writer.encode(Int16.init(value & 0xFFF))
    }
}

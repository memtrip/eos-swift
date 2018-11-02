import Foundation

protocol DataWriter : AbiTypeWriter {
}

class DataWriterValue : DataWriter, Encodable {

    private let hexAsBytes: Data

    init(hex: String) {
        self.hexAsBytes = DefaultHexWriter().hexToBytes(hex: hex)
    }

    func encode(writer: AbiEncodingContainer) throws {
        try writer.encode(UInt64.init(hexAsBytes.count))
        try writer.encodeBytes(value: [UInt8](hexAsBytes))
    }
}

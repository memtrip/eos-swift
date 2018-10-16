import Foundation

protocol TimestampWriter : AbiTypeWriter, Encodable {
}

class TimestampWriterValue : TimestampWriter {

    private let timestamp: UInt64

    init(timestamp: UInt64) {
        self.timestamp = timestamp
    }

    func encode(writer: AbiEncodingContainer) throws {
        try writer.encode(Int64.init(timestamp/1000))
    }
}

import Foundation

protocol TimestampWriter : AbiTypeWriter {
}

class TimestampWriterValue : TimestampWriter, Encodable {

    private let timestamp: Double

    init(date: Date) {
        self.timestamp = date.timeIntervalSince1970
    }

    func encode(writer: AbiEncodingContainer) throws {
        try writer.encode(Int32.init(timestamp/1000))
    }
}

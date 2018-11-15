import Foundation

protocol NameWriter : AbiTypeWriter {
}

public class NameWriterValue : NameWriter, Encodable {

    private let NAME_MAX_LENGTH = 12

    private let name: String

    public init(name: String) {
        self.name = name
    }
    
    func encode(writer: AbiEncodingContainer) throws {
        try writer.encode(nameAsInt64(name: name))
    }

    func nameAsInt64(name: String) -> Int64 {
        let len = name.count
        var value: Int64 = 0

        for i in 0..<NAME_MAX_LENGTH {
            var c: Int64 = 0

            if (i < len && i <= NAME_MAX_LENGTH) {
                c = Int64.init(charToSymbol(c: name[i].toUInt8()))
            }

            if (i < NAME_MAX_LENGTH) {
                c = c & 0x1f
                c = c <<  (64 - 5 * (i + 1))
            } else {
                c = c & 0x0f
            }

            value = value | c
        }

        return value
    }

    private func charToSymbol(c: UTF8Char) -> UInt8 {

        if (c >= "a"[0].toUInt8() && c <= "z"[0].toUInt8()) {
            return UInt8.init((c - "a"[0].toUInt8()) + 6)
        }

        if (c >= "1"[0].toUInt8() && c <= "5"[0].toUInt8()) {
            return UInt8.init((c - "1"[0].toUInt8()) + 1)
        }

        return UInt8.init(0)
    }
}

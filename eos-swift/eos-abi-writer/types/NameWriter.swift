import Foundation

protocol NameWriter : AbiTypeWriter, Encodable {
}

class NameWriterValue : NameWriter {

    private let NAME_MAX_LENGTH = 12

    private let name: String

    init(name: String) {
        self.name = name
    }
    
    func encode(writer: AbiEncodingContainer) throws {
        try writer.encode(nameAsUInt64(name: name))
    }

    private func nameAsUInt64(name: String) -> UInt64 {
        let len = name.count
        var value: UInt64 = 0

        for i in 0...NAME_MAX_LENGTH {
            var c: UInt64 = 0

            if (i < len && i <= NAME_MAX_LENGTH) {
                c = UInt64.init(charToSymbol(c: UTF8Char.init(String(name[i]))!))
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

        if (c >= UTF8Char.init("a")! && c <= UTF8Char.init("z")!) {
            return UInt8.init((c - UTF8Char.init("a")!) + 6)
        }

        if (c >= UTF8Char.init("1")! && c <= UTF8Char.init("5")!) {
            return UInt8.init((c - UTF8Char.init("1")!) + 1)
        }

        return UInt8.init(0)
    }
}

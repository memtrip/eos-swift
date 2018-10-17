import Foundation

class DefaultHexWriter : HexWriter {

    func bytesToHex(bytes: [UInt8]) -> String {
        return bytesToHex(bytes: bytes, offset: 0, length: bytes.count, seperator: nil)
    }

    func bytesToHex(bytes: [UInt8], offset: Int, length: Int, seperator: String?) -> String {
        var result = ""
        for index in 0..<length {
            let unsignedByte = bytes[index + offset] & 0xff
            if (unsignedByte < 16) {
                result += "0"
            }
            result += String(format:"%02X", unsignedByte)
            if let seperator = seperator {
                if (index + 1 < length) {
                    result += seperator
                }
            }
        }
        return result
    }

    func hexToBytes(hex: String) -> [UInt8] {
        if hex.count % 2 != 0 {
            fatalError("Assertion failure: Hex must contain an even amount of characters")
        }
        var bytes = [UInt8]()
        bytes.reserveCapacity(hex.count / 2)
        var index = hex.startIndex
        for _ in 0..<(hex.count / 2) {
            let nextIndex = hex.index(index, offsetBy: 2)
            if let b = UInt8(hex[index..<nextIndex], radix: 16) {
                bytes.append(b)
            } else {
                fatalError("Assertion failure: Failed to create hex bytes")
            }
            index = nextIndex
        }
        return bytes
    }
}

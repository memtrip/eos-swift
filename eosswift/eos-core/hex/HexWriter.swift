import Foundation

protocol HexWriter {
    func hexToBytes(hex: String) -> Data
}

class DefaultHexWriter : HexWriter {

    func hexToBytes(hex: String) -> Data {
        var data = Data(capacity: hex.count / 2)

        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: hex, range: NSMakeRange(0, hex.utf16.count)) { match, flags, stop in
            let byteString = (hex as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)!
            data.append(&num, count: 1)
        }

        guard data.count > 0 else {
            fatalError()
        }

        return data
    }
}

extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

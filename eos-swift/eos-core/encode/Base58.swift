import Foundation

class Base58 {

    static func decodeWithChecksum(base58: String) -> Data {
        let data = Data(base58Decoding: base58)!
        return data.subdata(in: 0..<data.count-4)
    }

    static func encodeWithChecksum(prefix: String, signaturePrefix: String = "", data: Data) -> String {
        let checksum = Base58.encodeChecksum(prefix: signaturePrefix, data: data)
        var dataWithChecksum = Data(repeating: 0, count: data.count + 4)
        dataWithChecksum[0..<data.count] = data[0..<data.count]
        dataWithChecksum[data.count..<data.count+4] = checksum[0..<4]

        if (signaturePrefix.count == 0) {
            return prefix + String(base58Encoding: dataWithChecksum)
        } else {
            return prefix + "_" + signaturePrefix + "_" + String(base58Encoding: dataWithChecksum)
        }
    }

    static func encodeChecksum(prefix: String, data: Data) -> Data {
        let prefixByteArray: Data = prefix.data(using: .utf8)!
        var dataWithChecksum = Data(repeating: 0, count: data.count + prefix.count)
        dataWithChecksum[0..<data.count] = data[0..<data.count]
        dataWithChecksum[data.count..<data.count+prefixByteArray.count] = prefixByteArray[0..<prefixByteArray.count]
        return RIPEMD160.hash(message: dataWithChecksum)
    }
}

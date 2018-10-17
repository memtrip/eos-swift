import Foundation

class Base58 {

    let ALPHABET: [UInt8]
    let ENCODED_ZERO: UInt8
    var INDEXES: [Int]

    init() {
        ALPHABET = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".toUint8()
        ENCODED_ZERO = ALPHABET[0]
        INDEXES = Array<Int>(repeating: -1, count: 128)
        for index in 0...ALPHABET.count-1 {
            INDEXES[ALPHABET[index].toInt()] = index
        }
    }

    /**
     * Encodes the given bytes as a base58 string (no checksum is appended).
     */
    func encode(with: [UInt8]) -> String {
        var input = with
        if (input.count == 0) {
            return ""
        }
        // Count leading zeros.
        var zeros = 0
        while (zeros < input.count && input[zeros] == 0) {
            zeros = zeros + 1
        }
        // Convert base-256 digits to base-58 digits (plus conversion to ASCII characters)
        var encoded: [UInt8] = Array<UInt8>(repeating: 0, count: input.count * 2)
        var outputStart = encoded.count
        var inputStart = zeros
        while (inputStart < input.count) {
            outputStart = outputStart - 1
            encoded[outputStart] = ALPHABET[divmod(number: &input, firstDigit: inputStart, base: 256, divisor: 58).toInt()]
            if (input[inputStart] == 0) {
                inputStart = inputStart + 1
            }
        }

        while (outputStart < encoded.count && encoded[outputStart] == ENCODED_ZERO) {
            outputStart = outputStart + 1
        }
        zeros = zeros - 1
        while (zeros >= 0) {
            encoded[outputStart] = ENCODED_ZERO
            zeros = zeros - 1
        }
        // Return encoded string (including encoded leading zeros).
        return String(bytes: Array(encoded[outputStart..<encoded.count]), encoding: .utf8)!
    }

    /**
     * Encodes the given version and bytes as a base58 string. A checksum is appended.
     */
    func decode(input: String) throws -> [UInt8] {
        if (input.count == 0) {
            return Array<UInt8>()
        }
        // Convert the base58-encoded ASCII chars to a base58 byte sequence (base58 digits).
        var input58 = Array<UInt8>(repeating: 0, count: input.count)
        for index in 0...input58.count-1 {
            let c: UInt8 = input[index].toUInt8()
            let digit = c < 127 ? INDEXES[c.toInt()] : -1
            if (digit < 0) {
                throw AddressFormatException.invalidCharacter(input[index], index)
            }
            input58[index] = digit.toUInt8()
        }
        // Count leading zeros.
        var zeros = 0
        while (zeros < input58.count && input58[zeros] == 0) {
            zeros = zeros + 1
        }
        // Convert base-58 digits to base-256 digits.
        var decoded = Array<UInt8>(repeating: 0, count: input.count)
        var outputStart = decoded.count
        var inputStart = zeros
        while (inputStart < input58.count) {
            outputStart = outputStart - 1
            decoded[outputStart] = divmod(number: &input58, firstDigit: inputStart, base: 58, divisor: 256)
            if (input58[inputStart] == 0) {
                inputStart = inputStart + 1
            }
        }
        // Ignore extra leading zeroes that were added during the calculation.
        while (outputStart < decoded.count && decoded[outputStart] == 0) {
            outputStart = outputStart + 1
        }
        // Return decoded data (including original number of leading zeros).
        return Array(decoded[(outputStart - zeros)..<decoded.count])
    }

    /**
     * Decodes the given base58 string into the original data bytes, using the checksum in the
     * last 4 bytes of the decoded data to verify that the rest are correct. The checksum is
     * removed from the returned data.
     */
    func decodeChecked(input: String) throws -> [UInt8] {
        let decoded: [UInt8] = try decode(input: input)
        if (decoded.count < 4) {
            throw AddressFormatException.invalidDataLength("Input too short: ", decoded.count)
        }
        let data: [UInt8] = Array(decoded[0..<decoded.count-4])
        let checksum: [UInt8] = Array(decoded[decoded.count-4..<decoded.count])
        let dataHash: [UInt8] = Sha256Hash.hashTwice(data: Data(bytes: data)).toArray(type: UInt8.self)
        let actualChecksum: [UInt8] = Array(dataHash[0..<4])
        if (checksum != actualChecksum) {
            throw AddressFormatException.invalidChecksum()
        }
        return data
    }

    /**
     * Divides a number, represented as an array of bytes each containing a single digit
     * in the specified base, by the given divisor. The given number is modified in-place
     * to contain the quotient, and the return value is the remainder.
     */
    private func divmod(number: inout [UInt8], firstDigit: Int, base: Int, divisor: Int) -> UInt8 {
        // this is just long division which accounts for the base of the input digits
        var remainder = 0

        for index in firstDigit...number.count-1 {
            let digit: Int = (number[index] & 0xFF).toInt()
            let temp = remainder * base + digit
            number[index] = (temp / divisor).toUInt8()
            remainder = temp % divisor
        }

        return remainder.toUInt8()
    }

    enum AddressFormatException: Error, Equatable {
        case invalidCharacter(Character, Int)
        case invalidDataLength(String, Int)
        case invalidChecksum()
        case versionNotInRange()

        static func ==(lhs: AddressFormatException, rhs: AddressFormatException) -> Bool {
            switch (lhs, rhs) {
            case (let .invalidCharacter(codeA1, codeB1), let .invalidCharacter(codeA2, codeB2)):
                return codeA1 == codeA2 && codeB1 == codeB2
            case (let .invalidDataLength(code1), let .invalidDataLength(code2)):
                return code1 == code2
            case (.invalidChecksum, .invalidChecksum):
                return true
            case (.versionNotInRange, .versionNotInRange):
                return true
            default:
                return false
            }
        }
    }
}

import Foundation

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }

    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    func toUint8() -> [UInt8] {
        return [UInt8](self.utf8)
    }

    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

public extension Date {

    public static func defaultTransactionExpiry() -> Date {
        return Date(timeIntervalSince1970: (Date().timeIntervalSince1970) + 120)
    }
}

extension Character {
    func toUInt8() -> UInt8 {
        return Array(String(self).utf8)[0]
    }

    func toString() -> String {
        return String(self)
    }
}

extension UInt8 {

    func toInt() -> Int {
        return Int.init(self)
    }

    static func toInt(array: [UInt8]) -> Int {
        let data = Data(bytes: array)
        return Int(bigEndian: data.withUnsafeBytes { $0.pointee })
    }
}

extension Int8 {

    func toInt() -> Int {
        return Int.init(self)
    }

    static func toInt(array: [Int8]) -> Int {
        let data = Data(bytes: array, count: MemoryLayout<Int8>.size)
        return Int(bigEndian: data.withUnsafeBytes { $0.pointee })
    }
}

extension Int {
    func toUInt8() -> UInt8 {
        return UInt8.init(self)
    }

    func toInt8() -> Int8 {
        return Int8.init(self)
    }
}

extension Data {

    func toArray<T>(type: T.Type) -> [T] {
        return self.withUnsafeBytes {
            [T](UnsafeBufferPointer(start: $0, count: self.count/MemoryLayout<T>.stride))
        }
    }

    func toUInt8Array() -> [UInt8] {
        return [UInt8](self)
    }

    func subdata(in range: ClosedRange<Index>) -> Data {
        return subdata(in: range.lowerBound ..< range.upperBound + 1)
    }

    enum Endianness {
        case BigEndian
        case LittleEndian
    }
    
    func scanValue<T: FixedWidthInteger>(at index: Data.Index, endianess: Endianness) -> T {
        let number: T = self.subdata(in: index..<index + MemoryLayout<T>.size).withUnsafeBytes({ $0.pointee })
        switch endianess {
        case .BigEndian:
            return number.bigEndian
        case .LittleEndian:
            return number.littleEndian
        }
    }
}

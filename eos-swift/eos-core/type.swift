import Foundation

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }

    func toUint8() -> [UInt8] {
        return [UInt8](self.utf8)
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
}

extension Int {
    func toUInt8() -> UInt8 {
        return UInt8.init(self)
    }
}

extension Data {

    func toArray<T>(type: T.Type) -> [T] {
        return self.withUnsafeBytes {
            [T](UnsafeBufferPointer(start: $0, count: self.count/MemoryLayout<T>.stride))
        }
    }
}

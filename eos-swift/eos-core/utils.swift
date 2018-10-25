import Foundation

class Utils {

    static func readUint32(data: Data, offset: Int) -> Int64 {

        let bytes = data.withUnsafeBytes {
            [Int64](UnsafeBufferPointer(start: $0, count: MemoryLayout<Int64>.size))
        }

        let byte1: Int64 = bytes[offset] & Int64(0xff)
        let byte2: Int64 = bytes[offset + 1] & Int64(0xff) << 8
        let byte3: Int64 = bytes[offset + 2] & Int64(0xff) << 16
        let byte4: Int64 = bytes[offset + 3] & Int64(0xff) << 24

        return byte1 | byte2 | byte3 | byte4
    }
}

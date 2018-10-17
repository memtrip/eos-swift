import Foundation

protocol HexWriter {

    func bytesToHex(bytes: [UInt8]) -> String

    func bytesToHex(bytes: [UInt8], offset: Int, length: Int, seperator: String?) -> String

    func hexToBytes(hex: String) -> [UInt8]
}

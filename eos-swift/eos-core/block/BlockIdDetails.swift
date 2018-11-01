import Foundation
import BigInt

class BlockIdDetails {

    let blockNum: Int
    let blockPrefix: UInt32

    init(blockId: String) {
        let hexWriter: HexWriter = DefaultHexWriter()
        blockNum = Int(BigUInt(hexWriter.hexToBytes(hex: blockId[0...7])))
        blockPrefix = hexWriter.hexToBytes(hex: blockId[16...23]).scanValue(at: 0, endianess: .LittleEndian) as UInt32
    }
}

import Foundation
import BigInt

class BlockIdDetails {

    let blockNum: Int16
    let blockPrefix: Int64

    init(blockId: String) {
        let hexWriter: HexWriter = DefaultHexWriter()
        blockNum = Int16(BigUInt(hexWriter.hexToBytes(hex: blockId[0...7])))
        blockPrefix = Int64.init(hexWriter.hexToBytes(hex: blockId[16...23]).scanValue(at: 0, endianess: .LittleEndian) as UInt32)
    }
}

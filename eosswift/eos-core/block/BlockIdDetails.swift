import Foundation
import BigInt

public class BlockIdDetails {

    let blockNum: Int
    let blockPrefix: Int64

    public init(blockId: String) {
        let hexWriter: HexWriter = DefaultHexWriter()
        blockNum = Int(BigUInt(hexWriter.hexToBytes(hex: blockId[0...7])))
        blockPrefix = Int64.init(hexWriter.hexToBytes(hex: blockId[16...23]).scanValue(at: 0, endianess: .LittleEndian) as UInt32)
    }
}

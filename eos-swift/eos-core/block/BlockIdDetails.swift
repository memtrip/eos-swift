import Foundation
import BigInt

class BlockIdDetails {

    let blockNum: Int
    let blockPrefix: Int64

    init(blockId: String) {
        let hexWriter: HexWriter = DefaultHexWriter()
        blockNum = Int(BigUInt(hexWriter.hexToBytes(hex: blockId[0...7])))
        blockPrefix = Utils.readUint32(data: hexWriter.hexToBytes(hex: blockId[16...23]), offset: 0)
    }
}

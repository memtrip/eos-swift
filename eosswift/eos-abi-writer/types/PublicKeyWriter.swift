import Foundation

protocol PublicKeyWriter : AbiTypeWriter {
}

public class PublicKeyWriterValue : DataWriter, Encodable {

    private let publicKeyBytes: [UInt8]
    private let isCurveParamK1: Bool

    public init(publicKey: EOSPublicKey, isCurveParamK1: Bool) {
        self.publicKeyBytes = [UInt8](publicKey.bytes())
        self.isCurveParamK1 = isCurveParamK1
    }

    func encode(writer: AbiEncodingContainer) throws {
        try writer.encode(PublicKeyWriterValue.type(isCurveParamK1: isCurveParamK1))
        try writer.encodeBytes(value: publicKeyBytes)
    }

    private static func type(isCurveParamK1: Bool) -> UInt64 {
        if (isCurveParamK1) {
            return UInt64.init(0)
        } else {
            return UInt64.init(1)
        }
    }
}

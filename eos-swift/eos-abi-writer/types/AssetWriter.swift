import Foundation

protocol AssetWriter : AbiTypeWriter, Encodable {
}

class AssetWriteValue : AssetWriter {

    private let asset: String

    init(asset: String) {
        self.asset = asset
    }

    func encode(writer: AbiEncodingContainer) throws {

    }
}

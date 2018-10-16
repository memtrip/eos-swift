import Foundation

protocol AssetWriter : AbiTypeWriter, Encodable {
}

class AssetWriteValue : AssetWriter {

    private let asset: String

    init(asset: String) {
        self.asset = asset
    }

    func encode(writer: AbiEncodingContainer) throws {
        let regex = try NSRegularExpression(pattern: "^([0-9]+)\\.?([0-9]*)([ ][a-zA-Z0-9]{1,7})?$")

        if let match = regex.firstMatch(in: asset, range: NSMakeRange(0, asset.count)) {
            let groups = match.groups(testedString: asset)
            let beforeDotVal = groups[1]
            let afterDotVal = groups[2]
            let symbol = groups[3]
            let amount: Int64 = Int64.init(String("\(beforeDotVal)\(afterDotVal)"))!

            if (symbol != "") {
                try writer.encode(amount)
            } else {
                throw InvalidAssetFormatError.error("Invalid asset format")
            }
        } else {
            throw InvalidAssetFormatError.error("Invalid asset format")
        }
    }

    enum InvalidAssetFormatError: Error {
        case error(String)
    }
}

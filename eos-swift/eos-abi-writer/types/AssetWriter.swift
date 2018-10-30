import Foundation

protocol AssetWriter : AbiTypeWriter {
}

class AssetWriterValue : AssetWriter, Encodable {

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
            let symbol = groups[3].trim()
            let amount: Int64 = Int64.init(String("\(beforeDotVal)\(afterDotVal)"))!
            try writer.encode(amount)

            if (symbol != "") {
                try writeSymbol(precision: afterDotVal.count, symbol: symbol, writer: writer)
            } else {
                try writer.encode(UInt64.init(0))
            }
        } else {
            throw InvalidAssetFormatError.asset("Invalid asset format")
        }
    }

    private func writeSymbol(precision: Int, symbol: String, writer: AbiEncodingContainer) throws {
        var result: Int64 = 0

        if (symbol != "") {
            for index in 0..<symbol.count {
                let value = Int64.init(symbol[index].toUInt8())
                // check range 'A' to 'Z'
                if (value < 65 || value > 90) {
                    throw InvalidAssetFormatError.symbol("invalid currency symbol string: \(symbol)")
                }
                result = result | value << (8 * (1 + index))
            }

            result = result | Int64.init(precision)

            try writer.encode(result)
        } else {
            throw InvalidAssetFormatError.symbol("empty currency symbol")
        }
    }

    private func validateSymbolName(name: String) -> Bool {
        for index in 0..<name.count {
            let value = name[index].toUInt8()
            if (value < 97 || value > 122) {
                return false
            }
        }

        return true
    }

    enum InvalidAssetFormatError: Error {
        case asset(String)
        case symbol(String)
    }
}

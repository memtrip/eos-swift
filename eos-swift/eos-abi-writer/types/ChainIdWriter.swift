import Foundation

protocol ChainIdWriter : AbiTypeWriter, Encodable {
}

class ChainIdWriterValue : ChainIdWriter {

    private let chainId: String

    init(chainId: String) {
        self.chainId = chainId
    }

    func encode(writer: AbiEncodingContainer) throws {
    }
}

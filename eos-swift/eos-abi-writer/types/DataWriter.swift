import Foundation

protocol DataWriter : AbiTypeWriter {
}

class DataWriterValue : DataWriter, Encodable {

    private let chainId: String

    init(chainId: String) {
        self.chainId = chainId
    }

    func encode(writer: AbiEncodingContainer) throws {
        // TODO - required the hex writer
    }
}

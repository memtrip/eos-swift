import Foundation

protocol DataWriter : AbiTypeWriter, Encodable {
}

class DataWriterValue : DataWriter {

    private let chainId: String

    init(chainId: String) {
        self.chainId = chainId
    }

    func encode(writer: AbiEncodingContainer) throws {
        // TODO - required the hex writer
    }
}

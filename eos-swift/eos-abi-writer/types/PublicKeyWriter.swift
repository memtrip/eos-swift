import Foundation

protocol PublicKeyWriter : AbiTypeWriter {
}

class PublicKeyWriterValue : DataWriter, Encodable {

    private let publicKey: String

    init(publicKey: String) {
        self.publicKey = publicKey
    }

    func encode(writer: AbiEncodingContainer) throws {
        // TODO - requires EOS public key
    }
}

import Foundation

protocol PublicKeyWriter : AbiTypeWriter, Encodable {
}

class PublicKeyWriterValue : DataWriter {

    private let publicKey: String

    init(publicKey: String) {
        self.publicKey = publicKey
    }

    func encode(writer: AbiEncodingContainer) throws {
        // TODO - requires EOS public key
    }
}

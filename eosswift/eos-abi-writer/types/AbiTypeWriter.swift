import Foundation

protocol AbiTypeWriter {
    func encode(writer: AbiEncodingContainer) throws
}

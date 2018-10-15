import Foundation

class AbiEncoder : Encoder {

    var codingPath: [CodingKey] = []

    var userInfo: [CodingUserInfoKey : Any] = [:]

    let abiEncodingContainer: AbiEncodingContainer

    init(capacity: Int) {
        abiEncodingContainer = AbiEncodingContainer(capacity: capacity)
    }

    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        fatalError("A SingleValueEncodingContainer contains the abi encoded value")
    }

    func unkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError("A SingleValueEncodingContainer contains the abi encoded value")
    }

    func singleValueContainer() -> SingleValueEncodingContainer {
        return abiEncodingContainer
    }
}

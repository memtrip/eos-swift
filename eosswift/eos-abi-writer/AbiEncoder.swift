import Foundation

public class AbiEncoder : Encoder {

    public var codingPath: [CodingKey] = []

    public var userInfo: [CodingUserInfoKey : Any] = [:]

    private let abiEncodingContainer: AbiEncodingContainer

    func toData() -> Data {
        return abiEncodingContainer.toData()
    }

    public init(capacity: Int) {
        abiEncodingContainer = AbiEncodingContainer(capacity: capacity)
    }

    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        fatalError("container<Key> not supported")
    }

    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        return abiEncodingContainer
    }

    public func singleValueContainer() -> SingleValueEncodingContainer {
        fatalError("singleValueContainer not supported")
    }
}

extension AbiEncoder {

    func encode(encodable: Encodable) throws {
        let mirror = Mirror(reflecting: encodable)
        for child in mirror.children {
            switch (child.value) {
            case is Bool:
                try abiEncodingContainer.encode(child.value as! Bool)
            case is String:
                try abiEncodingContainer.encode(child.value as! String)
            case is Double:
                try abiEncodingContainer.encode(child.value as! Double)
            case is Float:
                try abiEncodingContainer.encode(child.value as! Float)
            case is Int:
                try abiEncodingContainer.encode(child.value as! Int)
            case is Int8:
                try abiEncodingContainer.encode(child.value as! Int8)
            case is Int16:
                try abiEncodingContainer.encode(child.value as! Int16)
            case is Int32:
                try abiEncodingContainer.encode(child.value as! Int32)
            case is Int64:
                try abiEncodingContainer.encode(child.value as! Int64)
            case is UInt8:
                try abiEncodingContainer.encode(child.value as! UInt8)
            case is UInt16:
                try abiEncodingContainer.encode(child.value as! UInt16)
            case is UInt32:
                try abiEncodingContainer.encode(child.value as! UInt32)
            case is UInt64:
                try abiEncodingContainer.encode(child.value as! UInt64)
            case is NameWriter:
                try abiEncodingContainer.encode(child.value as! NameWriter)
            case is AccountNameWriter:
                try abiEncodingContainer.encode(child.value as! AccountNameWriter)
            case is BlockNumWriter:
                try abiEncodingContainer.encode(child.value as! BlockNumWriter)
            case is BlockPrefixWriter:
                try abiEncodingContainer.encode(child.value as! BlockPrefixWriter)
            case is PublicKeyWriter:
                try abiEncodingContainer.encode(child.value as! PublicKeyWriter)
            case is AssetWriter:
                try abiEncodingContainer.encode(child.value as! AssetWriter)
            case is ChainIdWriter:
                try abiEncodingContainer.encode(child.value as! ChainIdWriter)
            case is DataWriter:
                try abiEncodingContainer.encode(child.value as! DataWriter)
            case is TimestampWriter:
                try abiEncodingContainer.encode(child.value as! TimestampWriter)
            case is StringCollectionWriter:
                try abiEncodingContainer.encode(child.value as! StringCollectionWriter)
            case is HexCollectionWriter:
                try abiEncodingContainer.encode(child.value as! HexCollectionWriter)
            case is AccountNameCollectionWriter:
                try abiEncodingContainer.encode(child.value as! AccountNameCollectionWriter)
            case is [Encodable]:
                let encodableValues = child.value as! [Encodable]
                try self.abiEncodingContainer.encode(UInt64.init(encodableValues.count))
                for encodable in encodableValues {
                    try self.encode(encodable: encodable)
                }
            case is Encodable:
                try self.encode(encodable: child.value as! Encodable)
            default:
                fatalError("type not supported")
            }
        }
    }
}

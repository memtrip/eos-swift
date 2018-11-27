import Foundation

public class SafeString: Codable {
    
    public let value: String
    
    public init(value: String) {
        self.value = value
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let intValue = try container.decode(Int.self)
            value = String(intValue)
        } catch DecodingError.typeMismatch {
            do {
                value = try container.decode(String.self)
            } catch DecodingError.typeMismatch {
                throw DecodingError.typeMismatch(SafeString.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Encoded payload not of an expected type"))
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        fatalError("encoding not supported")
    }
}

public class SafeInt64: Codable {
    
    public let value: Int64
    
    public init(value: Int64) {
        self.value = value
    }
    
    public required init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        
        do {
            value = try container.decode(Int64.self)
        } catch {
            do {
                let parsed: String = try container.decode(String.self)
                value = Int64.init(parsed)!
            } catch {
                value = -1
            }
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        fatalError("encoding not supported")
    }
}

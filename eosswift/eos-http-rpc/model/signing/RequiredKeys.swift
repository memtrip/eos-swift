import Foundation

public struct RequiredKeys : Decodable {
    public let required_keys: Array<String>

    public init(required_keys: Array<String>) {
        self.required_keys = required_keys
    }
}

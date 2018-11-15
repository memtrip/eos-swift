import Foundation

public struct BinaryHex : Decodable {
    public let binargs: String
    public let required_scope: Array<String>?
    public let required_auth: Array<String>?

    public init(binargs: String, required_scope: Array<String>?, required_auth: Array<String>?) {
        self.binargs = binargs
        self.required_scope = required_scope
        self.required_auth = required_auth
    }
}

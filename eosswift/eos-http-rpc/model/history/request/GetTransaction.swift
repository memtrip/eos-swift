import Foundation

public struct GetTransaction : Encodable {
    public let id: String

    public init(id: String) {
        self.id = id
    }
}

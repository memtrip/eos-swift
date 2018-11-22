import Foundation

public struct HttpResponse<D: Decodable> {
    public let statusCode: Int
    public let success: Bool
    public let body: D?

    public init(statusCode: Int, body: D?) {
        self.statusCode = statusCode
        self.success = statusCode >= 200 && statusCode <= 299
        self.body = body
    }
}

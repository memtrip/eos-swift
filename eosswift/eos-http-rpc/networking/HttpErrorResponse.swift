import Foundation

public struct HttpErrorResponse<E: Decodable> : Error {
    public let statusCode: Int
    public let body: E?
    public let bodyString: String?
    
    public init(statusCode: Int, body: E?, bodyString: String?) {
        self.statusCode = statusCode
        self.body = body
        self.bodyString = bodyString
    }
}

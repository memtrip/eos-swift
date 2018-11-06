import Foundation

struct HttpErrorResponse<E: Decodable> : Error {
    public let statusCode: Int
    public let body: E?
    public let bodyString: String?
}

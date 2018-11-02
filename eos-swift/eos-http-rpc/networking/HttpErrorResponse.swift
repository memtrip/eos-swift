import Foundation

struct HttpErrorResponse<E: Decodable> : Error {
    let statusCode: Int
    let body: E?
    let bodyString: String?
}

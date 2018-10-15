import Foundation

struct HttpResponse<D: Decodable> {
    let statusCode: Int
    let success: Bool
    let body: D?

    init(statusCode: Int, body: D?) {
        self.statusCode = statusCode
        self.success = statusCode >= 200 && statusCode <= 299
        self.body = body
    }
}

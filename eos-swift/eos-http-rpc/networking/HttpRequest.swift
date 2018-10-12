import Foundation
import Alamofire

struct HttpRequest<T : Encodable> {
    let url: String
    let method: HTTPMethod
    let jsonBody: T? = nil
    let headers: HTTPHeaders = [:]
}

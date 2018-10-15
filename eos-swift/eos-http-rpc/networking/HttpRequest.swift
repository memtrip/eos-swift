import Foundation
import Alamofire

struct HttpRequest<T : Encodable> {
    let url: String
    let method: HTTPMethod
    let body: T?
    let headers: HTTPHeaders = [:]
}

import Foundation

struct HttpRequest<T : Encodable> {
    let url: String
    let method: String
    let body: T?
    let headers: [String:String] = [:]
}

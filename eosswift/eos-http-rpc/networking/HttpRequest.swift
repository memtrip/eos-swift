import Foundation

public struct HttpRequest<T : Encodable> {
    public let url: String
    public let method: String
    public let body: T?
    public let headers: [String:String] = [:]
    
    public init(url: String, method: String, body: T?) {
        self.url = url
        self.method = method
        self.body = body
    }
}

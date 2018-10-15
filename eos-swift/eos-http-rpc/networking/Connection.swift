import Foundation

protocol Connection {
    func request(
        urlRequest: URLRequest,
        closure: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

class ConnectionImpl: Connection {

    fileprivate init() {
    }

    func request(
        urlRequest: URLRequest,
        closure: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            closure(data, response, error)
        }
    }
}

class ConnectionFactory {
    static func create() -> Connection {
        return ConnectionImpl()
    }
}

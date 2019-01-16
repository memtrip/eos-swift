import Foundation

public protocol Connection {
    
    func request(
        urlRequest: URLRequest,
        closure: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

class ConnectionImpl: Connection {

    private let urlSession: URLSession
    
    fileprivate init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func request(
        urlRequest: URLRequest,
        closure: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        return self.urlSession.dataTask(with: urlRequest) { (data, response, error) in
            closure(data, response, error)
        }
    }
}

class ConnectionFactory {
    static func create(urlSession: URLSession) -> Connection {
        return ConnectionImpl(urlSession: urlSession)
    }
}

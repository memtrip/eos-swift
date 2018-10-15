import Foundation
import Alamofire

protocol Connection {
    func request(
        _ url: String,
        httpMethod: HTTPMethod,
        httpHeaders: HTTPHeaders,
        jsonData: Data?
    ) -> Alamofire.DataRequest
}

class AlmoConnection: Connection {

    fileprivate init() {
    }

    func request(
        _ url: String,
        httpMethod: HTTPMethod,
        httpHeaders: HTTPHeaders,
        jsonData: Data?
        ) -> DataRequest {

        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")

        httpHeaders.forEach { key, value in
            request.setValue(key, forHTTPHeaderField: value)
        }

        if let json = jsonData {
            request.httpBody = json
        }

        return Alamofire.request(request)
    }
}

class ConnectionFactory {
    static func create() -> Connection {
        return AlmoConnection()
    }
}

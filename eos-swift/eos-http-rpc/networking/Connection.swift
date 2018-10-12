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

class ConnectionFactory {
    static func create() -> Connection {
        return AlmoConnection()
    }
}

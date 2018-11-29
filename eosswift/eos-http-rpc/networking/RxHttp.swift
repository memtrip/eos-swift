import Foundation
import RxSwift

public class RxHttp<REQ: Encodable, RES: Decodable, ERR: Decodable> {

    private let connection: Connection = ConnectionFactory.create()
    private let useLogger: Bool
    private let logger: Logger
    
    public init(_ useLogger: Bool) {
        self.useLogger = useLogger
        self.logger = Logger(useLogger: useLogger)
    }
    
    public func single(httpRequest: HttpRequest<REQ>) -> Single<HttpResponse<RES>> {
        return Single<HttpResponse<RES>>.create { single in
            return self.call(
                httpRequest: httpRequest,
                onSuccess: { response in single(.success(response)) },
                onError: { error in single(.error(error)) }
            )
        }
    }

    public func completable(httpRequest: HttpRequest<REQ>) -> Completable {
        return Completable.create { completable in
            return self.call(
                httpRequest: httpRequest,
                onSuccess: { _ in
                    completable(.completed)
                },
                onError: { error in
                    completable(.error(error)) }
                )
        }
    }

    private func call(
        httpRequest: HttpRequest<REQ>,
        onSuccess: @escaping ((_ response: HttpResponse<RES>) -> Void),
        onError: @escaping ((_ error: HttpErrorResponse<ERR>) -> Void)
    ) -> Disposable {

        logger.log(value: httpRequest.url)
        logger.log(value: "method:\(String(describing: httpRequest.method))")
        logger.log(value: "headers:\(String(describing: httpRequest.headers))")

        var request = URLRequest(url: URL(string: httpRequest.url)!)

        request.httpMethod = httpRequest.method

        httpRequest.headers.forEach { key, value in
            request.setValue(key, forHTTPHeaderField: value)
        }

        if let json = body(httpRequest: httpRequest) {
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = json
            logger.log(value: json)
        }

        let task = connection.request(urlRequest: request) { (data, response, error) in

            if let res = response as? HTTPURLResponse {
                self.logger.log(value: "status_code: \(res.statusCode)")

                if res.statusCode >= 200 && res.statusCode < 300 {
                    if let body = data {
                        do {
                            self.logger.log(value: body)
                            let stringBody = String(decoding: body, as: UTF8.self)
                            let decodedBody = try self.jsonDecoder().decode(RES.self, from: stringBody.data(using: .utf8)!)
                            onSuccess(HttpResponse(statusCode: res.statusCode, body: decodedBody))
                        } catch {
                            self.logger.log(value: "Error info: \(error)")
                            onError(HttpErrorResponse(statusCode: -999, body: nil, bodyString: nil))
                        }
                    } else {
                        onSuccess(HttpResponse(statusCode: res.statusCode, body: nil))
                    }
                } else {

                    if let body = data {
                        let bodyString = String(describing: String(data: body, encoding: .utf8))
                        self.logger.log(value: "error_response: \(bodyString)")
                        do {
                            do {
                                let decodedBody = try JSONDecoder().decode(ERR.self, from: body)
                                onError(HttpErrorResponse(statusCode: res.statusCode, body: decodedBody, bodyString: bodyString))
                            } catch {
                                onError(HttpErrorResponse(statusCode: res.statusCode, body: nil, bodyString: bodyString))
                            }
                        }
                    } else {
                        onError(HttpErrorResponse(statusCode: res.statusCode, body: nil, bodyString: nil))
                    }
                }
            } else {
                self.logger.err(value: error!)
                onError(HttpErrorResponse(statusCode: -111, body: nil, bodyString: ""))
            }
        }
        
        task.resume()

        return Disposables.create {
            task.cancel()
        }
    }

    private func body(httpRequest: HttpRequest<REQ>) -> Data? {
        if let jsonBody = httpRequest.body {
            return try! jsonEncoder().encode(jsonBody)
        } else {
            return nil
        }
    }

    private func logJsonData(data: Data) -> String {
        let str = String(describing: String(data: data, encoding: String.Encoding.utf8))
        return String(str.filter { !" \n\t\r\\".contains($0) })
    }

    enum DateError: String, Error {
        case invalidDate
    }

    private func jsonDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            throw DateError.invalidDate
        })
        return decoder
    }

    private func jsonEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        encoder.dateEncodingStrategy = .formatted(formatter)
        return encoder
    }
}

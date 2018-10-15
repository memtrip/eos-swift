import Foundation
import RxSwift

class RxHttp<REQ: Encodable, RES: Decodable, ERR: Codable> {

    let encoder = JSONEncoder()
    let connection: Connection = ConnectionFactory.create()

    func single(httpRequest: HttpRequest<REQ>) -> Single<HttpResponse<RES>> {
        return Single<HttpResponse<RES>>.create { single in
            return self.call(
                httpRequest: httpRequest,
                onSuccess: { response in single(.success(response)) },
                onError: { error in single(.error(error)) }
            )
        }
    }

    func completable(httpRequest: HttpRequest<REQ>) -> Completable {
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

        Logger.log(value: httpRequest.url)
        Logger.log(value: "method:\(String(describing: httpRequest.method))")
        Logger.log(value: "headers:\(String(describing: httpRequest.headers))")

        var request = URLRequest(url: URL(string: httpRequest.url)!)

        request.httpMethod = httpRequest.method.rawValue

        httpRequest.headers.forEach { key, value in
            request.setValue(key, forHTTPHeaderField: value)
        }

        if let json = body(httpRequest: httpRequest) {
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = json
            Logger.log(value: json)
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let res = response as? HTTPURLResponse {
                Logger.log(value: "status_code: \(res.statusCode)")

                if res.statusCode >= 200 && res.statusCode < 300 {

                    if let body = data {
                        do {
                            Logger.log(value: data)
                            let decodedBody = try self.jsonDecoder().decode(RES.self, from: body)
                            onSuccess(HttpResponse(statusCode: res.statusCode, body: decodedBody))
                        } catch {
                            onError(HttpErrorResponse(statusCode: -999, body: nil))
                        }
                    } else {
                        onSuccess(HttpResponse(statusCode: res.statusCode, body: nil))
                    }
                } else {

                    if let body = data {
                        do {
                            let decodedBody = try JSONDecoder().decode(ERR.self, from: body)
                            Logger.log(value: "error_response: \(decodedBody)")
                            onError(HttpErrorResponse(statusCode: res.statusCode, body: decodedBody))
                        } catch {
                            onError(HttpErrorResponse(statusCode: res.statusCode, body: nil))
                        }
                    } else {
                        onError(HttpErrorResponse(statusCode: res.statusCode, body: nil))
                    }
                }
            } else {
                Logger.err(value: error!)
                onError(HttpErrorResponse(statusCode: -111, body: nil))
            }
        }
        
        task.resume()

        return Disposables.create {
            task.cancel()
        }
    }

    private func body(httpRequest: HttpRequest<REQ>) -> Data? {
        if let jsonBody = httpRequest.body {
            return try! JSONEncoder().encode(jsonBody)
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
}

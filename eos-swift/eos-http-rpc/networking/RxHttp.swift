import Foundation
import RxSwift
import Alamofire

class Http<T: Codable, R: Codable, E: Codable> {

    let encoder = JSONEncoder()
    let connection: Connection = ConnectionFactory.create()

    func single(httpRequest: HttpRequest<T>) -> Single<HttpResponse<R>> {
        return Single<HttpResponse<R>>.create { single in
            return self.call(
                httpRequest: httpRequest,
                onSuccess: { response in single(.success(response)) },
                onError: { error in single(.error(error)) }
            )
        }
    }

    func completable(httpRequest: HttpRequest<T>) -> Completable {
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
        httpRequest: HttpRequest<T>,
        onSuccess: @escaping ((_ response: HttpResponse<R>) -> Void),
        onError: @escaping ((_ error: HttpErrorResponse<E>) -> Void)
    ) -> Disposable {

        Logger.log(value: httpRequest.url)
        Logger.log(value: "method:\(String(describing: httpRequest.method))")
        Logger.log(value: "headers:\(String(describing: httpRequest.headers))")
        Logger.log(value: "params:\(String(describing: httpRequest.jsonBody))")

        let jsonData: Data?
        do {
            jsonData = try encoder.encode(httpRequest.jsonBody)
        } catch {
            jsonData = nil
            onError(HttpErrorResponse(statusCode: -2, body: nil))
        }

        connection.request(
            httpRequest.url,
            httpMethod: httpRequest.method,
            httpHeaders: httpRequest.headers,
            jsonData: jsonData
        ).responseData { response in

            if let res = response.response {

                Logger.log(value: "status_code: \(res.statusCode)")

                if res.statusCode >= 200 && res.statusCode < 300 {

                    if let body = response.result.value {

                        Logger.log(value: "response: \(body)")

                        do {
                            let decodedBody = try JSONDecoder().decode(R.self, from: body)
                            onSuccess(HttpResponse(statusCode: res.statusCode, body: decodedBody))
                        } catch {
                            onError(HttpErrorResponse(statusCode: -9, body: nil))
                        }
                    } else {
                        onSuccess(HttpResponse(statusCode: res.statusCode, body: nil))
                    }
                } else {

                    if let body = response.result.value {

                        Logger.log(value: "error_response: \(body)")

                        do {
                            let decodedBody = try JSONDecoder().decode(E.self, from: body)
                            onError(HttpErrorResponse(statusCode: res.statusCode, body: decodedBody))
                        } catch {
                            onError(HttpErrorResponse(statusCode: res.statusCode, body: nil))
                        }
                    } else {
                        onError(HttpErrorResponse(statusCode: res.statusCode, body: nil))
                    }
                }
            } else {
                onError(HttpErrorResponse(statusCode: -1, body: nil))
            }
        }

        return Disposables.create()
    }
}

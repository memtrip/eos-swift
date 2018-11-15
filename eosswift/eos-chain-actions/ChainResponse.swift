import Foundation

public struct ChainResponse<T: Decodable> {
    public let success: Bool
    public let statusCode: Int
    public let body: T?
    public let errorBody: String?

    public init(success: Bool, statusCode: Int, body: T?) {
        self.success = success
        self.statusCode = statusCode
        self.body = body
        self.errorBody  = nil
    }

    public init(success: Bool, statusCode: Int, errorBody: String?) {
        self.success = success
        self.statusCode = statusCode
        self.errorBody = errorBody
        self.body = nil
    }
}

extension ChainResponse {
    static func errorResponse() -> ChainResponse<T> {
        return ChainResponse<T>(
            success: false,
            statusCode: 400,
            errorBody: nil
        )
    }
}

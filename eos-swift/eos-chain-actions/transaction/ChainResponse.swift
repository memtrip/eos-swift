import Foundation

struct ChainResponse<T: Decodable> {
    let success: Bool
    let statusCode: Int
    let body: T?
    let errorBody: String?
}

extension ChainResponse {
    static func errorResponse() -> ChainResponse<T> {
        return ChainResponse<T>(
            success: false,
            statusCode: 400,
            body: nil,
            errorBody: nil
        )
    }
}

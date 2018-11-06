import Foundation

public struct RefundBody : Encodable {
    public let args: RefundArgs

    public init(args: RefundArgs) {
        self.args = args
    }
}

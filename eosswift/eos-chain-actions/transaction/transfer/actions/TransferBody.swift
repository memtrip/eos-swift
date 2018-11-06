import Foundation

public struct TransferBody : Encodable {
    public let args: TransferArgs

    public init(args: TransferArgs) {
        self.args = args
    }
}

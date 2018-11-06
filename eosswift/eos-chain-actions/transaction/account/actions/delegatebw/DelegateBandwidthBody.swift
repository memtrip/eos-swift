import Foundation

public struct DelegateBandwidthBody : Encodable {
    public let args: DelegateBandwidthArgs

    public init(args: DelegateBandwidthArgs) {
        self.args = args
    }
}

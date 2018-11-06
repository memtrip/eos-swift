import Foundation

public struct UnDelegateBandwidthBody : Encodable {
    public let args: UnDelegateBandwidthArgs

    public init(args: UnDelegateBandwidthArgs) {
        self.args = args
    }
}

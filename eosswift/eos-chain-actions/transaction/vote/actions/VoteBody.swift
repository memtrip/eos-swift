import Foundation

public struct VoteBody : Encodable {
    public let args: VoteArgs

    public init(args: VoteArgs) {
        self.args = args
    }
}

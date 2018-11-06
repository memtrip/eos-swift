import Foundation

public struct NewAccountBody : Encodable {
    public let args: NewAccountArgs

    public init(args: NewAccountArgs) {
        self.args = args
    }
}

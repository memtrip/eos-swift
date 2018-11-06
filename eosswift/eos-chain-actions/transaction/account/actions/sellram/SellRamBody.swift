import Foundation

public struct SellRamBody : Encodable {
    public let args: SellRamArgs

    public init(args: SellRamArgs) {
        self.args = args
    }
}

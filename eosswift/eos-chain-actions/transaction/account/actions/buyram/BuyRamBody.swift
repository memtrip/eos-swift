import Foundation

public struct BuyRamBody : Encodable {
    let args: BuyRamArgs

    public init(args: BuyRamArgs) {
        self.args = args
    }
}

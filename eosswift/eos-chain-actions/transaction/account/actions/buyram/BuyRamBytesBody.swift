import Foundation

public struct BuyRamBytesBody : Encodable {
    let args: BuyRamBytesArgs

    public init(args: BuyRamBytesArgs) {
        self.args = args
    }
}

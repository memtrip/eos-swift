import Foundation

public extension RIPEMD160 {

    public static func hash(message: Data) -> Data {
        var md = RIPEMD160()
        md.update(data: message)
        return md.finalize()
    }

    public static func hash(message: String) -> Data {
        return RIPEMD160.hash(message: message.data(using: .utf8)!)
    }
}

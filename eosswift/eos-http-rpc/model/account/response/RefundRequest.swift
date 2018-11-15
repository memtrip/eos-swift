import Foundation

public struct RefundRequest : Decodable {
    public let owner: String
    public let request_time: Date
    public let net_amount: String
    public let cpu_amount: String

    public init(owner: String, request_time: Date, net_amount: String, cpu_amount: String) {
        self.owner = owner
        self.request_time = request_time
        self.net_amount = net_amount
        self.cpu_amount = cpu_amount
    }
}

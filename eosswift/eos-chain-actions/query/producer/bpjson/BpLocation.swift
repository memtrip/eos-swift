import Foundation

public struct BpLocation : Decodable {
    public let name: String
    public let country: String
    public let latitude: Double
    public let longitude: Double
}

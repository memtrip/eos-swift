import Foundation

struct BpLocation : Decodable {
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
}

import Foundation

struct AccountResourceLimit : Codable {
    let used: Int64
    let available: Int64
    let max: Int64

    /// The Account api response mixes both String and Int64 types for the available and max fields.
    /// The hack below is the result of this poor api design.
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)

        if let parseUsed: Int64 = try keyedContainer.decodeIfPresent(Int64.self, forKey: .used) {
            used = parseUsed
        } else {
            used = -1
        }

        var avaliableVal: Int64 = -1
        var maxVal: Int64 = -1

        do {
            if let parseAvailable: String = try keyedContainer.decodeIfPresent(String.self, forKey: .available) {
                avaliableVal = Int64.init(parseAvailable)!
            }
            if let parseMax: String = try keyedContainer.decodeIfPresent(String.self, forKey: .max) {
                maxVal = Int64.init(parseMax)!
            }
        } catch { }

        available = avaliableVal
        max = maxVal
    }
}

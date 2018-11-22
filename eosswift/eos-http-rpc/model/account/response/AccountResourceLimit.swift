import Foundation

public struct AccountResourceLimit : Codable {
    public let used: Int64
    public let available: Int64
    public let max: Int64

    public init(used: Int64, available: Int64, max: Int64) {
        self.used = used
        self.available = available
        self.max = max
    }

    /// The Account api response mixes both String and Int64 types for the available and max fields.
    /// The hack below is the result of this poor api design.
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)

        if let parseUsed: Int64 = try keyedContainer.decodeIfPresent(Int64.self, forKey: .used) {
            used = parseUsed
        } else {
            if let parseUsedString: String = try keyedContainer.decodeIfPresent(String.self, forKey: .used) {
                used = Int64.init(parseUsedString)!
            } else {
                used = -1
            }
        }
        
        if let parseAvailable: Int64 = try keyedContainer.decodeIfPresent(Int64.self, forKey: .available) {
            available = parseAvailable
        } else {
            if let parseAvailableString: String = try keyedContainer.decodeIfPresent(String.self, forKey: .available) {
                available = Int64.init(parseAvailableString)!
            } else {
                available = -1
            }
        }
        
        if let parseMax: Int64 = try keyedContainer.decodeIfPresent(Int64.self, forKey: .max) {
            max = parseMax
        } else {
            if let parseMaxString: String = try keyedContainer.decodeIfPresent(String.self, forKey: .max) {
                max = Int64.init(parseMaxString)!
            } else {
                max = -1
            }
        }
    }
}

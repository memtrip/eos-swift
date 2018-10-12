import Foundation

struct AccountResourceLimit : Codable {
    let used: UInt64
    let available: UInt64
    let max: UInt64
}

import Foundation

class TestUtils {
    static func generateUniqueAccountName() -> String {
        let length = 12
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }

    static func randomNumber() -> String {
        return "\(Int.random(in: 1..<5))"
    }
}

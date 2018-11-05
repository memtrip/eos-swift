import Foundation

class TestUtils {
    static func generateUniqueAccountName() -> String {
        return "\(TestUtils.randomNumber())\(TestUtils.randomNumber())\(TestUtils.randomNumber())\(TestUtils.randomNumber())\(TestUtils.randomNumber())\(TestUtils.randomNumber())\(TestUtils.randomNumber())\(TestUtils.randomNumber())\(TestUtils.randomNumber())\(TestUtils.randomNumber())"
    }

    static func randomNumber() -> String {
        return "\(Int.random(in: 1..<5))"
    }
}

import Foundation

extension NSTextCheckingResult {
    func groups(testedString:String) -> [String] {
        var groups = [String]()
        for i in  0 ..< self.numberOfRanges {
            let group = String(testedString[Range(self.range(at: i), in: testedString)!])
            groups.append(group)
        }
        return groups
    }
}

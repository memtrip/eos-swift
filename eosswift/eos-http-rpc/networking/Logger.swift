import Foundation

class Logger: NSObject {

    static func log(value: Data?) {
        self.log(value: self.logJsonData(data: value!), trim: false)
    }

    static func log(value: String) {
        self.log(value: value, trim: false)
    }

    static func err(value: Error) {
        self.log(value: value.localizedDescription, trim: true)
    }

    static func log(value: String, trim: Bool) {
        #if DEBUG
        if trim && value.count > 1000 {
            print(">> \(value.prefix(999))...")
        } else {
            print(">> \(value)")
        }
        #endif
    }

    private static func logJsonData(data: Data) -> String {
        let str = String(describing: String(data: data, encoding: String.Encoding.utf8))
        return String(str.filter { !" \n\t\r\\".contains($0) })
    }
}

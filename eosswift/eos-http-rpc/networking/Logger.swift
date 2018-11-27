import Foundation

class Logger: NSObject {

    private let useLogger: Bool
    
    init(useLogger: Bool) {
       self.useLogger = useLogger
    }
    
    func log(value: Data?) {
        if (useLogger) {
            self.log(value: self.logJsonData(data: value!), trim: false)
        }
    }

    func log(value: String) {
        if (useLogger) {
            self.log(value: value, trim: false)
        }
    }

    func err(value: Error) {
        if (useLogger) {
            self.log(value: value.localizedDescription, trim: true)
        }
    }

    func log(value: String, trim: Bool) {
        if (useLogger) {
            if trim && value.count > 1000 {
                print(">> \(value.prefix(999))...")
            } else {
                print(">> \(value)")
            }
        }
    }

    private func logJsonData(data: Data) -> String {
        let str = String(describing: String(data: data, encoding: String.Encoding.utf8))
        return String(str.filter { !" \n\t\r\\".contains($0) })
    }
}

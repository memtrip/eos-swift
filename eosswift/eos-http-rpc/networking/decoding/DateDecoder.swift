import Foundation

class DateDecoder {
    
    private let formatter: DateFormatter
    
    init(formatter: DateFormatter) {
        self.formatter = formatter
    }
    
    func decode(dateStr: String) throws -> Date {
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        if let date = formatter.date(from: dateStr) {
            return date
        }
        throw DateError.invalidDate
    }
}

enum DateError: String, Error {
    case invalidDate
}

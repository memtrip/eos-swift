import Foundation

protocol AccountNameWriter : AbiTypeWriter {
}

public class AccountNameWriterValue : AccountNameWriter, Encodable {

    private let MAX_LENGTH = 12
    private let ILLEGAL_CHARACTER = "."

    private let name: String

    public init(name: String) {
        self.name = name
    }

    func value() -> String {
        return name
    }

    func encode(writer: AbiEncodingContainer) throws {
        if (name.count > MAX_LENGTH) {
            throw AccountNameError.error("Account name cannot be more than 12 characters. => $name")
        }
        try NameWriterValue(name: name).encode(writer: writer)
    }

    enum AccountNameError: Error {
        case error(String)
    }
}

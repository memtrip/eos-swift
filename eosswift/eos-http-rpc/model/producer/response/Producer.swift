import Foundation

public struct Producer : Codable {
    public let owner: String
    public let total_votes: String
    public let producer_key: String
    public let is_active: Int
    public let url: String
    public let unpaid_blocks: Int
    public let last_claim_time: Int64
    public let location: Int

    public init(owner: String, total_votes: String, producer_key: String, is_active: Int, url: String, unpaid_blocks: Int, last_claim_time: Int64, location: Int) {
        self.owner = owner
        self.total_votes = total_votes
        self.producer_key = producer_key
        self.is_active = is_active
        self.url = url
        self.unpaid_blocks = unpaid_blocks
        self.last_claim_time = last_claim_time
        self.location = location
    }

    /// The Producer api response mixes both String and Int64 types for the last_claim_time.
    /// The hack below is the result of this poor api design.
    public init(from decoder: Decoder) throws {

        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)

        if let parsedOwner: String = try keyedContainer.decodeIfPresent(String.self, forKey: .owner) {
            owner = parsedOwner
        } else {
            throw ProducerParsingError.parseError
        }

        if let parsedTotalVotes: String = try keyedContainer.decodeIfPresent(String.self, forKey: .total_votes) {
            total_votes = parsedTotalVotes
        } else {
            throw ProducerParsingError.parseError
        }

        if let parsedProducerKey: String = try keyedContainer.decodeIfPresent(String.self, forKey: .producer_key) {
            producer_key = parsedProducerKey
        } else {
            throw ProducerParsingError.parseError
        }

        if let parsedIsActive: Int = try keyedContainer.decodeIfPresent(Int.self, forKey: .is_active) {
            is_active = parsedIsActive
        } else {
            throw ProducerParsingError.parseError
        }

        if let parsedUrl: String = try keyedContainer.decodeIfPresent(String.self, forKey: .url) {
            url = parsedUrl
        } else {
            throw ProducerParsingError.parseError
        }

        if let parsedUnPaidBlocks: Int = try keyedContainer.decodeIfPresent(Int.self, forKey: .unpaid_blocks) {
            unpaid_blocks = parsedUnPaidBlocks
        } else {
            throw ProducerParsingError.parseError
        }

        if let parsedLocation: Int = try keyedContainer.decodeIfPresent(Int.self, forKey: .location) {
            location = parsedLocation
        } else {
            throw ProducerParsingError.parseError
        }

        do {
            if let parseLastClaimTime: String = try keyedContainer.decodeIfPresent(String.self, forKey: .last_claim_time) {
       
                if let last_claim_time = Int64.init(parseLastClaimTime) {
                    self.last_claim_time = last_claim_time
                } else {
                    do {
                        let dateDecoder = DateDecoder(formatter: DateFormatter())
                        let dateValue = try dateDecoder.decode(dateStr: parseLastClaimTime)
                        last_claim_time = Int64.init(dateValue.timeIntervalSince1970)
                    } catch {
                        last_claim_time = 0
                    }
                }
            } else if let parseLastClaimTime: Int64 = try keyedContainer.decodeIfPresent(Int64.self, forKey: .last_claim_time) {
                last_claim_time = parseLastClaimTime
            } else {
                last_claim_time = 0
            }
        } catch {
            last_claim_time = 0
        }
    }
}

enum ProducerParsingError : Error {
    case parseError
}

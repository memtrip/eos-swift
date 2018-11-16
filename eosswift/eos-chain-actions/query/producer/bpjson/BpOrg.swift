import Foundation

public struct BpOrg : Decodable {
    public let candidate_name: String
    public let website: String
    public let code_of_conduct: String
    public let ownership_disclosure: String
    public let email: String
    public let branding: BpBranding
    public let location: BpLocation
    public let social: BpSocial
}

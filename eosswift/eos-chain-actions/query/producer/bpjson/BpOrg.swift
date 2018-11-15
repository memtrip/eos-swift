import Foundation

struct BpOrg : Decodable {
    let candidate_name: String
    let website: String
    let code_of_conduct: String
    let ownership_disclosure: String
    let email: String
    let branding: BpBranding
    let location: BpLocation
    let social: BpSocial
}

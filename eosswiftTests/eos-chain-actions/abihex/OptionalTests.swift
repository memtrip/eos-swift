import Foundation
import XCTest

@testable import eosswift

class OptionalTests: XCTestCase {
    
    func testOptionalDecodable() {
        
        let userProfileAccountMetaArgs = UserProfileAccountMetaArgs(
            type: nil,
            app: nil,
            email: nil,
            phone: nil,
            facebook: nil,
            instagram: nil,
            telegram: nil,
            vk: nil,
            website: nil,
            first_name: nil,
            last_name: nil,
            name: "Samuel Kirton"
        )
        
        let userNameArgs = UserNameArgs(name: "Samuel Kirton")
        
        XCTAssertEqual(userProfileAccountMetaArgs.toHex(), userNameArgs.toHex())
    }
}

struct UserNameArgs: Encodable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

struct UserProfileAccountMetaArgs: Encodable {
    let type: String?
    let app: String?
    let email: String?
    let phone: String?
    let facebook: String?
    let instagram: String?
    let telegram: String?
    let vk: String?
    let website: String?
    let first_name: String?
    let last_name: String?
    let name: String
    
    init(
        type: String?,
        app: String?,
        email: String?,
        phone: String?,
        facebook: String?,
        instagram: String?,
        telegram: String?,
        vk: String?,
        website: String?,
        first_name: String?,
        last_name: String?,
        name: String
    ) {
        self.type = type
        self.app = app
        self.email = email
        self.phone = phone
        self.facebook = facebook
        self.instagram = instagram
        self.telegram = telegram
        self.vk = vk
        self.website = website
        self.first_name = first_name
        self.last_name = last_name
        self.name = name
    }
}

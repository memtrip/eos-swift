import Foundation
import XCTest

@testable import eosswift

class GetRegProxyInfoTests: XCTestCase {

    func testGetRegProxy() throws {
        let chainApi = ChainApiFactory.create(rootUrl: "http://api.eosnewyork.io/")
        let page1Response = try GetRegProxyInfo(chainApi: chainApi)
            .getProxies(limit: 100).asObservable().toBlocking().first()!
        let page2Response = try GetRegProxyInfo(chainApi: chainApi)
            .getProxies(limit: 100, nextAccount: page1Response.last!.owner)
            .asObservable().toBlocking().first()!

        page2Response.forEach { proxyJson in
            page1Response.forEach { proxyJsonInner in
                XCTAssertFalse(proxyJson.owner == proxyJsonInner.owner)
            }
        }
    }

    func testGetSingleProxy() throws {
        let chainApi = ChainApiFactory.create(rootUrl: "http://api.eosnewyork.io/")
        let response = try GetRegProxyInfo(chainApi: chainApi)
            .getProxy(accountName: "amazinggamer").asObservable().toBlocking().first()!
        XCTAssertEqual("amazinggamer", response.owner)
    }
}

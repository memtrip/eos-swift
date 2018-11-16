import Foundation
import RxSwift

public class CheckAccountNameExists {

    private let chainApi: ChainApi

    public init(chainApi: ChainApi) {
        self.chainApi = chainApi
    }

    public func checkAccountNameExists(accountName: String) -> Single<Bool> {
        return chainApi.getAccount(body: AccountName(account_name: accountName)).map { response in
            return response.success
        }.catchErrorJustReturn(false)
    }
}

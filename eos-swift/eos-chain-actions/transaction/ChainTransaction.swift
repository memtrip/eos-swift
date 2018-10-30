import Foundation
import RxSwift

protocol ChainTransaction {
    func chainApi() -> ChainApi
}

extension ChainTransaction {
    func push(
        expirationDate: Date,
        actions: [ActionAbi],
        authorizingPrivateKey: EOSPrivateKey
    ) -> Single<ChainResponse<TransactionCommitted>> {
        return chainApi().getInfo().flatMap { info in
            if (info.success) {
                fatalError("not implemented")
            } else {
                return Single.just(ChainResponse.errorResponse())
            }
        }
    }
}

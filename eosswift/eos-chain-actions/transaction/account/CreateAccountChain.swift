import Foundation
import RxSwift

public class CreateAccountChain : ChainTransaction {

    public struct Args {
        public let newAccountName: String
        public let quantity: Quantity
        public let ownerPublicKey: EOSPublicKey
        public let activePublicKey: EOSPublicKey
        public let transfer: Bool

        public init(newAccountName: String, quantity: Quantity, ownerPublicKey: EOSPublicKey, activePublicKey: EOSPublicKey, transfer: Bool) {
            self.newAccountName = newAccountName
            self.quantity = quantity
            self.ownerPublicKey = ownerPublicKey
            self.activePublicKey = activePublicKey
            self.transfer = transfer
        }
    }

    public struct Quantity {
        public let ram: Int64
        public let net: String
        public let cpu: String

        public init(ram: Int64, net: String, cpu: String) {
            self.ram = ram
            self.net = net
            self.cpu = cpu
        }
    }

    private let _chainApi: ChainApi

    public init(chainApi: ChainApi) {
        self._chainApi = chainApi
    }

    public func chainApi() -> ChainApi {
        return _chainApi
    }

    public func createAccount(args: Args, transactionContext: TransactionContext, extraActionAbi: [ActionAbi]) -> Single<ChainResponse<TransactionCommitted>> {
        return push(
            expirationDate: Date.defaultTransactionExpiry(),
            actions: buildAbiList(args: args, transactionContext: transactionContext, extraActionAbi: extraActionAbi),
            authorizingPrivateKey: transactionContext.authorizingPrivateKey)
    }

    private func buildAbiList(args: Args, transactionContext: TransactionContext, extraActionAbi: [ActionAbi]) -> [ActionAbi] {
        var abiList: [ActionAbi] = []

        abiList.append(ActionAbi(
            account: AccountNameWriterValue(name: "eosio"),
            name: AccountNameWriterValue(name: "newaccount"),
            authorization: [TransactionAuthorizationAbi(
                actor: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
                permission: AccountNameWriterValue(name: "active"))],
            data: DataWriterValue(hex: newAccountAbiHex(args: args, transactionContext: transactionContext))
        ))
        abiList.append(ActionAbi(
            account: AccountNameWriterValue(name: "eosio"),
            name: AccountNameWriterValue(name: "buyrambytes"),
            authorization: [TransactionAuthorizationAbi(
                actor: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
                permission: AccountNameWriterValue(name: "active"))],
            data: DataWriterValue(hex: buyRamBytesAbiHex(args: args, transactionContext: transactionContext))
        ))
        abiList.append(ActionAbi(
            account: AccountNameWriterValue(name: "eosio"),
            name: AccountNameWriterValue(name: "delegatebw"),
            authorization: [TransactionAuthorizationAbi(
                actor: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
                permission: AccountNameWriterValue(name: "active"))],
            data: DataWriterValue(hex: delegateBandwidthAbi(args: args, transactionContext: transactionContext))
        ))
        abiList.append(contentsOf: extraActionAbi)
        return abiList
    }

    private func newAccountAbiHex(args: Args, transactionContext: TransactionContext) -> String {
        let newAccountArgs = NewAccountArgs(
            creator: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
            name: AccountNameWriterValue(name: args.newAccountName),
            owner: AccountRequiredAuthAbi(
                threshold: 1,
                keys: [
                    AccountKeyAbi(
                        key: PublicKeyWriterValue(publicKey: args.ownerPublicKey, isCurveParamK1: true),
                        weight: 1)
                ],
                accounts: StringCollectionWriterValue(value: []),
                waits: StringCollectionWriterValue(value: [])
            ),
            active: AccountRequiredAuthAbi(
                threshold: 1,
                keys: [
                    AccountKeyAbi(
                        key: PublicKeyWriterValue(publicKey: args.activePublicKey, isCurveParamK1: true),
                        weight: 1)
                ],
                accounts: StringCollectionWriterValue(value: []),
                waits: StringCollectionWriterValue(value: [])
            )
        )
        return NewAccountBody(args: newAccountArgs).toHex()
    }

    private func buyRamBytesAbiHex(args: Args, transactionContext: TransactionContext) -> String {
        let buyRamBytesArgs: BuyRamBytesArgs = BuyRamBytesArgs(
            payer: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
            receiver: AccountNameWriterValue(name: args.newAccountName),
            bytes: args.quantity.ram
        )
        return BuyRamBytesBody(args: buyRamBytesArgs).toHex()
    }

    private func delegateBandwidthAbi(args: Args, transactionContext: TransactionContext) -> String {
        let delegateBandwidthArgs: DelegateBandwidthArgs = DelegateBandwidthArgs(
            from: AccountNameWriterValue(name: transactionContext.authorizingAccountName),
            receiver: AccountNameWriterValue(name: args.newAccountName),
            stake_net_quantity: AssetWriterValue(asset: args.quantity.net),
            stake_cpu_quantity: AssetWriterValue(asset: args.quantity.cpu),
            transfer: args.transfer ? 1 : 0)
        return DelegateBandwidthBody(args: delegateBandwidthArgs).toHex()
    }
}

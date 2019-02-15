# eos-swift
EOS libraries for swift, designed primarily for iOS development.

## Install with CocoaPods
Tested with pod --version: 1.5.3
```ruby
use_frameworks!

target 'YOUR_TARGET_NAME' do
  pod 'eosswift', '1.5'
end
```
Replace YOUR_TARGET_NAME and then, in the Podfile directory, type:
```
pod install
```

### Getting started
The `eosswiftTests` directory contains a full suite of integration tests, explore these
tests to quickly gauge what functionality is provided by the SDK.
- `eos-chain-actions` tests the highest level of abstraction; pushing transactions composed of actions.
- `eos-http-rpc` tests the interaction with nodeos HTTP RPC api.
- `eos-abi-writer` tests the building of local abi bytes

## eos-core
The core module contains the core building blocks required to interact with the EOS network.

### Key pairs
EOS keypairs are generated using the [micro-ecc](https://github.com/kmackay/micro-ecc) lib.

Create a new keypair:
```swift
// new key pair
let eosPrivateKey = try! EOSPrivateKey()
let eosPublicKey = eosPrivateKey.publicKey

// private key from encoded string
let privKey1 = try! EOSPrivateKey(base58: "5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3")

// private key from bytes
let privKey2 = try! EOSPrivateKey(ecKeyPrivateKey: ECPrivateKey(privKeyData: eosPrivateKey.bytes()))
```

### Sign bytes with a private key
When a transaction is pushed to the EOS network, the packed transaction bytes must be
signed by an EOS private key.
```swift
let bytesToSign = imaginaryAbi.toData()
let privateKey = try! EOSPrivateKey()
let signature = PrivateKeySigning().sign(digest: bytesToSign, eosPrivateKey: privateKey)
```

### Block Id details
Extract the block number and prefix from a block id.
```swift
let blockIdDetails = BlockIdDetails(blockId: "0000000ac7619ca01df1e0b4964921020e772ceb7343ec51f65537cdbce192d3")
let blockNum = blockIdDetails.blockNum
let blockPrefix = blockIdDetails.blockPrefix
```

## eos-abi-writer
A local replacement of abi_json_to_bin, the `Encodable` protocol is used with reflection to write struct
values to a byte array.

### Model
Byte writer models are structs that adopt the `Encodable` protocol, the type of the member variable
is used to determine how the data will be written to the byte array. For more complex types a derivative
of `AbiTypeWriter` can be used, such as; `AssetWriterValue`, `AccountNameWriter` or `PublicKeyWriter`.
- [List of complex `AbiTypeWriter` types](https://github.com/memtrip/eos-swift/tree/master/eosswift/eos-abi-writer/types)
```swift
struct TransactionAbi : Encodable {
    let expiration: TimestampWriterValue
    let ref_block_num: BlockNumWriterValue
    let ref_block_prefix: BlockPrefixWriterValue
    let max_net_usage_words: UInt64
    let max_cpu_usage_ms: UInt64
    let delay_sec: UInt64
    let context_free_actions: [ActionAbi]
    let actions: [ActionAbi]
    let transaction_extensions: StringCollectionWriterValue
}
```

### Write bytes
The `Encodable` protocol has two extension funcs called `toHex()` and `toData()`.
The `toData()` function will write the struct values to a byte array. The `toHex()`
function will write the struct values to a byte array and encode the bytes as a hexadecimal string,
in other words, an `abi_bin`.

### Examples
See the `eos-swiftTests/eos-chain-actions/abihex` test package for abi byte writing examples.

## eos-http-rpc
A http client used to makes requests to the nodeos RPC HTTP API.

### Factory
The http client interfaces can be created using `ChainApiFactory` and `HistoryApiFactory`.
```swift
let chainApi = ChainApiFactory.create(rootUrl: Config.CHAIN_API_BASE_URL)
```

### ChainApi
The `ChainApi` interface contains all the network requests for the `chain/` resource.
e.g; chain/get_info
```swift
chainApi.getInfo().subscribe(onSuccess: { response in
    let info: Info = response.body!
}, onError: { error in
    let httpErrorResponse = error as! HttpErrorResponse<ChainError>
    print(httpErrorResponse.bodyString)
})
```

The `HistoryApi` interface contains all the network requests for the `history/` resource.
e.g; history/get_transaction
```swift
historyApi.getTransaction(body: GetTransaction(id: action.action_trace.trx_id)).subscribe(onSuccess: { response in
     let historicTransaction: HistoricTransaction = response.body!
 }, onError: { error in
     let httpErrorResponse = error as! HttpErrorResponse<ChainError>
     print(httpErrorResponse.bodyString)
 })
```

## Credits
- [Join us on telegram](http://t.me/joinchat/JcIXl0x7wC9cRI5uF_EiQA)
- [Developed by memtrip.com](http://memtrip.com)

### Vote for memtripblock
If you find this SDK useful, please vote for [memtripblock](https://www.memtrip.com/code_of_conduct.html)
as a block producer. We are committed to open sourcing all the software we develop, let’s build the future of EOS on mobile together!

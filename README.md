# eos-swift
EOS libraries for swift, designed primarily for iOS development.

## Pod

## eos-core
The core module contains the core building blocks required to interact with the EOS network.

### Key pairs
EOS keypairs are generated using the [micro-ecc](https://github.com/kmackay/micro-ecc) lib.

Create a new keypair:
```
# generate new key pair
let eosPrivateKey = try! EOSPrivateKey()
let eosPublicKey = eosPrivateKey.publicKey

# from encoded string
let fromEncodedPrivateKey = try! EOSPrivateKey(base58: "5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3")

# from bytes
let fromBytesPrivateKey = try! EOSPrivateKey(ecKeyPrivateKey: ECPrivateKey(privKeyData: eosPrivateKey.bytes()))
```

### Sign bytes with a private key
When a transaction is pushed to the EOS network, the packed transaction bytes must be
signed by an EOS private key.

Sign bytes with an EOS private key:
```
#
let bytesToSign = imaginaryAbi.toData()
let privateKey = try! EOSPrivateKey()
let signature = PrivateKeySigning().sign(digest: bytesToSign, eosPrivateKey: privateKey)
```

### Block Id details
Extract the block number and prefix from a block id.
```
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
[List of supported complex `AbiTypeWriter` types](https://github.com/kmackay/micro-ecc)
```
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

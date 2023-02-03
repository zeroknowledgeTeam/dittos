# dittos ZKAA (Zero-Knowledge Address Abstraction) in aptos


## Basic Test

```sh
# run aptos node from zk-hack branch
aptos node run-local-testnet --with-faucet

# move directory
cd aptos_contract

# init (local network with default name)
aptos init

# fund-with-faucet
aptos account fund-with-faucet --account default

# publish 
aptos move publish --named-addresses dittos=default

# test
aptos move test --named-addresses dittos=default

```
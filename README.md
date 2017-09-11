This repo consists of 2 contracts to demonstrate solidity re-entrance vulnerability.

Go through the exercise to see for yourself.

1. Install testrpc

2. `git clone` and run `truffle migrate`

3.  Run this commands step by step in `truffle console` to see what re-entrance is



```
// 1. deposit 15 eth to Dao directly from accounts[0]
Attacker.deployed().then(function(ins) {ins.deposit({from: web3.eth.accounts[0], value: 15*10**18})})

// 2. get Dao contract balance. should be 15 ether
Attacker.deployed().then(function(ins) {ins.getDaoContractBalance.call().then(function (val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 3. get Attacker contract balance. should be 0 at the moment
Attacker.deployed().then(function(ins) {ins.getAttackerBalance.call().then(function (val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 4. Check balance of acct 1 in the dao. should be 15 eth
Attacker.deployed().then(function(ins) {ins.getDaoBalance.call(web3.eth.accounts[0]).then(function(val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 5. Attacker contract to start draining tao in steps of 0.02! Things get interesting...
Attacker.deployed().then(function(ins) {ins.attack()})

// 6. get all transaction log
Attacker.deployed().then(function(ins) {ins.logDeposit({},{fromBlock: 0, toBlock: 'latest'}).get(function(err, val) {console.log(val)})})
Attacker.deployed().then(function(ins) {ins.logPayment({},{fromBlock: 0, toBlock: 'latest'}).get(function(err, val) {console.log(val)})})

// 7. How many times did the attacker withdraw?
Attacker.deployed().then(function(ins) {ins.counter.call().then(function(val) {console.log(val.toNumber())})})

// 8. Check balance of Dao contract. should be less than x eth
Attacker.deployed().then(function(ins) {ins.getDaoContractBalance.call().then(function (val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 10. Check balance of attacker contract. How?
Attacker.deployed().then(function(ins) {ins.getAttackerBalance.call().then(function (val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 11. Final acct 1 balance (tx.origin)
web3.fromWei(web3.eth.getBalance(web3.eth.accounts[0]).toNumber())
```

## References

* [Withdrawal pattern](http://solidity.readthedocs.io/en/develop/common-patterns.html)
* [Ethereum gas and fees](https://www.linkedin.com/pulse/ethereum-gas-nutshell-bernard-peh)
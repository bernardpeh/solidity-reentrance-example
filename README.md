This repo consists of 2 contracts to demonstrate solidity re-entrance vulnerability.

Go through the exercise to see for yourself.

1. Install testrpc

2. `git clone` and run `truffle migrate`

3.  Run this commands step by step to see what re-entrance is

```
// 1. set Dao Address - should get a value
Attacker.deployed().then(function(ins) {ins.setDaoAddress("your_address")})

// 2. deposit 25 eth to Dao directly from accounts[0]
Dao.deployed().then(function(ins) {ins.deposit({from: web3.eth.accounts[0], value: 25*10**18})})

// 3. get Dao contract balance. should be 25 ether
Dao.deployed().then(function(ins) {ins.getBalance.call().then(function (val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 4. get Attacker contract balance. should be 0 at the moment
Attacker.deployed().then(function(ins) {ins.getBalance.call().then(function (val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 5. Attacker contract to start withdrawing! Things get interesting...
Attacker.deployed().then(function(ins) {ins.attack()})

// 6. How many times did the attacker withdraw?
Attacker.deployed().then(function(ins) {ins.counter.call().then(function(val) {console.log(val.toNumber())})})

// 7. Check balance of acct 1 in the dao. should be 25 eth
Dao.deployed().then(function(ins) {ins.balances.call(web3.eth.accounts[0]).then(function(val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 8. Check balance of Dao contract. should be less than 25 eth
Dao.deployed().then(function(ins) {ins.getBalance.call().then(function (val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 9. Check balance of attacker contract. How?
Attacker.deployed().then(function(ins) {ins.getBalance.call().then(function (val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// check acct 1 balance (Origin)
web3.fromWei(web3.eth.getBalance(web3.eth.accounts[0]).toNumber())
```

## References

* [Withdrawal pattern](http://solidity.readthedocs.io/en/develop/common-patterns.html)
* [Ethereum gas and fees](https://www.youtube.com/watch?v=dd-ajiMl4HY&feature=youtu.be)
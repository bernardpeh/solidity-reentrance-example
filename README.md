This repo consists of 2 contracts to demonstrate solidity re-entrance vulnerability.

Go through the exercise to see for yourself.

1. Install testrpc

2. `git clone` and run `truffle migrate`

3.  Run this commands step by step in `truffle console` to see what re-entrance is



```
// 1. acct 1 deposit 15 eth to Dao from Attacker Contract
Attacker.deployed().then(function(ins) {ins.deposit({from: web3.eth.accounts[1], value: 15*10**18})})

// 2. get Dao contract balance. should be 15 ether
Dao.deployed().then(function(ins) {ins.getBalance.call().then(function (val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 3. acct 2 deposit 7 eth to Dao directly from own acct
Dao.deployed().then(function(ins){ins.deposit({from: web3.eth.accounts[2],value: 7*10**18})})

// 4. get Dao contract balance. should be 22 ether now
Dao.deployed().then(function(ins) {ins.getBalance.call().then(function (val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 5. get Attacker contract balance. should be 0 ether
Attacker.deployed().then(function(ins) {ins.getBalance.call().then(function (val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 6. check acct 1 balance. should be around 84.99499. Why?
web3.fromWei(web3.eth.getBalance(web3.eth.accounts[1]).toNumber())

// 7. check acct 2 balance. should be around 92.99584. Why acct 2 pays lesser transaction fees?
web3.fromWei(web3.eth.getBalance(web3.eth.accounts[2]).toNumber())

// 8. Check balance of acct 1 in the dao. Why 0?
Dao.deployed().then(function(ins) {ins.balances(web3.eth.accounts[1]).then(function(val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 9. Check balance of Attacker contract in dao. why 15?
Dao.deployed().then(function(ins) {Attacker.deployed().then(att=>{return att.address}).then(address=>{ins.balances(address).then(val=>{console.log(web3.fromWei(val.toNumber(),'ether'))})})})

// 10. Check balance of acct 2 in the dao. should be 7 eth
Dao.deployed().then(function(ins) {ins.balances(web3.eth.accounts[2]).then(function(val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 11. acct 2 to withdraw directly from dao
Dao.deployed().then(function(ins) {ins.withdraw({from: web3.eth.accounts[2]})})

// 12. check acct 2 balance. 
web3.fromWei(web3.eth.getBalance(web3.eth.accounts[2]).toNumber())

// 13. check acct 2 balance in dao.
Dao.deployed().then(function(ins) {ins.balances(web3.eth.accounts[2]).then(function(val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})


// 13. get all transaction log
Attacker.deployed().then(function(ins) {ins.logDeposit({},{fromBlock: 0, toBlock: 'latest'}).get(function(err, val) {console.log(val)})})
Attacker.deployed().then(function(ins) {ins.logPayment({},{fromBlock: 0, toBlock: 'latest'}).get(function(err, val) {console.log(val)})})

// 7. How many times did the attacker withdraw? How?
Attacker.deployed().then(function(ins) {ins.counter.call().then(function(val) {console.log(val.toNumber())})})

// 8. Check balance of Dao contract. should be less than 15 eth.
Attacker.deployed().then(function(ins) {ins.getDaoContractBalance.call().then(function (val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 10. Check balance of attacker contract. I should be more than 0 eth. 
Attacker.deployed().then(function(ins) {ins.getAttackerBalance.call().then(function (val) {console.log(web3.fromWei(val.toNumber(),'ether'))})})

// 11. Final acct 1 balance (tx.origin)
web3.fromWei(web3.eth.getBalance(web3.eth.accounts[0]).toNumber())
```


```
Scenario:

Step 1: init

acct 1 balance:
99.900325 eth

Step 2: acct 1 deposit 15 ether to Attacker Contract

```
## References

* [Withdrawal pattern](http://solidity.readthedocs.io/en/develop/common-patterns.html)
* [Ethereum gas and fees](https://www.linkedin.com/pulse/ethereum-gas-nutshell-bernard-peh)
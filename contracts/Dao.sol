pragma solidity ^0.4.11;

contract Dao {

	mapping (address => uint) public balances;

	function deposit() payable {
		balances[msg.sender] += msg.value;
	}

	function withdraw(uint amount) {
		// require(balances[msg.sender] < amount);
		// msg.sender.call.value(amount)();
		msg.sender.call.value(amount)();
		balances[msg.sender] -= amount;
	}

	function getBalance() returns (uint){
		return this.balance;
	}

}



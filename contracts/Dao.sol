pragma solidity ^0.4.11;

contract Dao {

	mapping (address => uint) public balances;

	// received from contract only
	function deposit(address _sender) payable {
		balances[_sender] += msg.value;
	}

	function withdraw(uint amount) {
		// require(balances[msg.sender] < amount);
		// msg.sender.transfer(amount);
		// msg.sender.send(amount);
		msg.sender.call.value(amount)();
		balances[msg.sender] -= amount;
	}

	function getBalance() returns (uint){
		return this.balance;
	}

}



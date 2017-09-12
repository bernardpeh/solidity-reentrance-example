pragma solidity ^0.4.11;

contract Dao {

	mapping (address => uint) public balances;

	// received from contract only
	function deposit() payable {
		balances[msg.sender] += msg.value;
	}

	function withdraw() {
		require(balances[msg.sender] > 0);
		// msg.sender.transfer(balances[msg.sender]);
	 	msg.sender.call.value(balances[msg.sender])();
		balances[msg.sender] = 0;
	}

	function getBalance() returns(uint) {
		return this.balance;
	}
}



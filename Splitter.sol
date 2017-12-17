// In this contract, every value sent is supposed to be equally split between account one,
// account two and the contract itself. Beside finding out problems with it, how could an attacker game this contract
// and what would be the end result?

pragma solidity ^0.4.9;

contract Splitter {

    address public one;
    address public two;
    // define a new uint balance var 
    uint balance;

    // contructor accepts msg.value, hence it needs to be payable
    function Splitter(address _two) public payable {

        if (msg.value > 0) revert();
        // define balance here so we don't have to use this.balance later.
        balance = msg.value;

        // check _two not empty
        require(_two != address(0));

        one = msg.sender;
        two = _two;
        // check one and two cannot be same address
        assert(one != two);
    }

    function () public payable {

        // make sure value is > 0
        require(msg.value > 0);

        // To ensure fair distribution, we could check that payment is divisible by 3 first before we accept it.
        // Alternatively,  we could send the remainder back to the sender.
        balance += msg.value;
        if (balance % 3 > 0) {
            revert();
        }

        // Using this.balance here is flawed. The first time a payment is received, this.balance == msg.value.
        // However upon subsequent payment, this.balance adds msg.value to it. When divided by 3,
        // it means that this contract is paying a lot more and not getting its fair share.
        // For example pay a really high amount initially, say 60 eth. Then pay a small amount, say 3 eth next.
        // The result will be acct one and two will be left with 27.66 eth each whereas the contract, only 7.66 eth.
        
        // uint amount = this.balance / 3;
				
        uint amount = balance / 3;
				
        // Error in one.call.value(amount)() would stop two from getting the payment.
        // The problem could be fixed by using mapping to track address one and two balances, then allowing each of
        // the the accounts to withdraw separately in a new withdraw function.

        // Another problem is its forwarding all the gas which might opens door for re-entrance.
        // If there is really a need to allow contract to contract communication, we should specify gas limit.

        // require(one.call.value(amount)());
        // require(two.call.value(amount)());
				
        // In most cases, one and two are externally owned accounts, we should use send or transfer instead 
        one.transfer(amount);
        two.transfer(amount);

        // should also log an event if possible
        // LogPayment(msg.sender, amount, remainder, one, two)
    }
}


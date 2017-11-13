// What is happening here?
// Test it out in remix

pragma solidity ^0.4.13;

contract Bank {
    function getBalance() returns (uint){
        return this.balance;
    }
    function () payable {
        msg.sender.call.value(msg.value);
    }
    function deposit() payable {}
}

contract Hacker {
    Bank public b;
    uint public limit;
    function Hacker(address _bank) {
        b = Bank(_bank);
    }
    function getBalance() returns (uint){
        return this.balance;
    }
    function resetLimit() {
        limit = 0;
    }
    function () payable {
        if (limit < 3) {
            if (b.call.value(msg.value)()) {
                limit++;
            }
        }
    }
}

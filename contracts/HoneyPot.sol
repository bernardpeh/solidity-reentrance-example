pragma solidity ^0.4.13;

// Refer to deployed contract at https://ropsten.etherscan.io/address/0x935212B4d15cbF496FdDbFD63821ad4e04d0777d
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

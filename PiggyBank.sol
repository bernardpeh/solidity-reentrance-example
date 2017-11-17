// In this contract, value that is sent by the owner is being stored only if it is
// sent by the owner. It is returned in full when the contract is destroyed after
// the owner, and only the owner, sends the password to the kill function.

// No Pragma declared.
pragma solidity ^0.4.13;

contract PiggyBank {

    address owner;

    // There are no benefits of declaring uint248 here. Will cost more gas for evm to convert to uint256 when compiled.
    // uint248 balance;
    uint balance;
    bytes32 hashedPassword;

    // Assuming this is the constructor, it should be PigggyBank, not piggyBank
    // The constructor needs to be declared payable to receive ether.
    // function piggyBank(bytes32 _hashedPassword) {
    function PiggyBank(bytes32 _hashedPassword) payable {
        owner = msg.sender;
        // balance will be 0 when initialised. No need to += and type cast uint248.
        // balance += uint248(msg.value);
        balance = msg.value;
        hashedPassword = _hashedPassword;
    }

    function () payable {
        // Better idea to punish people for poking around?
        // if (msg.sender != owner) revert();
        require(msg.sender == owner);

        // we should check msg.value has a value
        require(msg.value > 0);

        // no more uint248 as per previously discussed.
        // balance += uint248(msg.value);
        balance += msg.value;

        // ensure no uint overflow here
        assert(balance >= msg.value);

        // should also log an event if possible
        // LogPayment(msg.sender, msg.value)
    }

    // password would be entered in plain text. Not too bad since its one time only and whole contract killed after that.
    function kill(bytes32 password) {

        // we should authenticate owner first
        require(msg.sender == owner);

        if (keccak256(owner, password) != hashedPassword) revert();

        selfdestruct(owner);
    }
}

// In this contract, a shop system processes a payment, sends the payment to a wallet contract
// and then instructs the warehouse to ship the purchase. What could go wrong?

pragma solidity ^0.4.5;

contract WarehouseI {
    function setDeliveryAddress(string where);
    function ship(uint id, address customer) returns (bool handled);
}

contract Store {
    address wallet;
    WarehouseI warehouse;

    function Store(address _wallet, address _warehouse) {
        // wallet and warehouse address cannot be 0
        require(_wallet != address(0) && _warehouse != address(0));

        wallet = _wallet;
        warehouse = WarehouseI(_warehouse);
    }

    // function needs to be payable
    function purchase(uint id) payable returns (bool success) {
        // send might fail and we still ship. In older version, we could do if and throw.
        // In current version, we could just use transfer.
        // wallet.send(msg.value);
        wallet.transfer(msg.value);

        // should also log an event if possible
        // LogPurchase(msg.sender, msg.value)

        return warehouse.ship(id, msg.sender);
    }
}

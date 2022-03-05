pragma solidity ^0.8.1;

contract StartStopUpdateExample {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    /// Enviar ETH para uma carteira
    function sendMoney() public payable {}

    // Sacar todo ETH da carteira
    function withdrawAllMoney(address payable _to) public {
        // Interrompe a  Programação aciona Erros (ou lança exceções)
        require(owner == msg.sender, "You cannot withdraw");
        _to.transfer(address(this).balance);
    }
}

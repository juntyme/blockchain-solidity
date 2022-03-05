// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract StartStopUpdateExample {
    address public owner;
    bool public paused;

    // Chamada apenas uma vez no contrato
    constructor() {
        owner = msg.sender;
    }

    // enviar ETH para o contrato
    function sendMoney() public payable {}

    // Variavel de escopo _paused
    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You are not the owner");
        paused = _paused;
    }

    function withdrawAllMoney(address payable _to) public {
        require(owner == msg.sender, "You cannot withdraw.");
        require(paused == false, "Contract Paused");
        _to.transfer(address(this).balance);
    }

    // mas podemos atualizar o estado atual para que você não possa mais interagir com um endereço daqui para frente
    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(_to);
    }

    // Ethereum Virtual Machine (EVM) 
}

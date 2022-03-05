//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract MappingsStructExample {
    mapping(address => uint256) public balanceReceived;

    // Recuperar valores enviados
    function getBalance() public view returns (uint256) {
        /// Recupera o saldo total das contas
        return address(this).balance;
    }

    // Depositar valores
    function sendMoney() public payable {
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint256 _amount) public {
        require(_amount <= balanceReceived[msg.sender], "not enough funds");
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    /// Savar Valores
    function withdrawAllMoney(address payable _to) public {
        uint256 balanceToSend = balanceReceived[msg.sender];
        balanceReceived[msg.sender] = 0;

        //Checks-Effects-Interaction  Isso segue o chamado padrão Checks-Effects-Interaction.
        //  Como regra geral: você interage com endereços externos por último
        _to.transfer(balanceToSend);
    }
}

//SPDX-License-Identifier: MIT

pragma solidity 0.8.1;

contract SharedWallet {

    // Variavel de estado proprietario
    address owner;

    // Construtor chama apenas uma vez
    constructor() {
        owner = msg.sender;
    }

    // Modificador só o Proprietário
    modifier onlyOwner() {
        /// Verificar entrada de dados
        require(msg.sender == owner, "You are not allowed");
        _;
    }

    //// Retirar fundos
    function withdrawMoney(address payable _to, uint256 _amount)
        public
        onlyOwner
    {
        _to.transfer(_amount);
    }

    /// Função Global fallback Adicionar fundos
    receive() external payable {}
}

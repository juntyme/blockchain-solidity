//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    /// Indexador para pesquisa indexed
    event AllowanceChanged(
        address indexed _forWho,
        address indexed _fromWhom,
        uint256 _oldAmount,
        uint256 _newAmount
    );

    /// Mapear endereços
    mapping(address => uint256) public allowance;

    /// Version ^0.8.0
    function isOwner() internal view returns (bool) {
        return owner() == msg.sender;
    }

    function addAllowance(address _who, uint256 _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] += _amount;
    }

    modifier ownerOrAllowed(uint256 _amount) {
        require(
            isOwner() || allowance[msg.sender] >= _amount,
            "You are not allowed"
        );
        _;
    }

    ///  Reduzir valores das carteioras
    function reduceAllowance(address _who, uint256 _amount) internal {
        emit AllowanceChanged(
            _who,
            msg.sender,
            allowance[_who],
            allowance[_who] - _amount
        );
        allowance[_who] -= _amount;
    }
}

contract SimpleWallet is Allowance {
    /// Carregar Logs
    event MoneySent(address indexed _beneficiary, uint256 _amount);
    event MoneyReceived(address indexed _from, uint256 _amount);

    // Função sacar dinheiro Proprietario ou Terceiros Liberados
    function withdrawMoney(address payable _to, uint256 _amount)
        public
        ownerOrAllowed(_amount)
    {
        require(
            _amount <= address(this).balance,
            "There are not enough funds stored in the smart contract"
        );
        if (!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }

        /// Enviar mensagem
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    /// Remover retirar Proprietario
    function renounceOwnership() public override onlyOwner {
        //  revert("can't renounceOwnership here"); //not possible with this smart contract
    }

    /// Funcion fallback
    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
}

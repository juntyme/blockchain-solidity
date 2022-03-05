//SPDX-License-Identifier: MIT

pragma solidity 0.8.1;

// Importar biblioteca da openZeppelin
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Allowance is Ownable {
    // Evento
    event AllowanceChanged(
        address indexed _forWho,
        address indexed _byWhom,
        uint256 _oldAmount,
        uint256 _newAmount
    );

    // Mapas de proprietários
    mapping(address => uint256) public allowance;

    // visualizar o proprietário
    function isOwner() internal view returns (bool) {
        return owner() == msg.sender;
    }

    function addAllowance(address _who, uint256 _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    // Verificação geral
    modifier ownerOrAllowed(uint256 _amount) {
        require(
            isOwner() || allowance[msg.sender] >= _amount,
            "You are not allowed!"
        );
        _;
    }

    function reduceAllowance(address _who, uint256 _amount) internal {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] -= _amount;
    }
}

contract SharedWallet is Allowance {
    event MoneySent(address indexed _beneficiary, uint256 _amount);
    event MoneyReceived(address indexed _from, uint256 _amount);

    function withdrawMoney(address payable _to, uint256 _amount)
        public
        ownerOrAllowed(_amount)
    {
        require(
            _amount <= address(this).balance,
            "Contract doesn't own enough money"
        );
        if (!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneyReceived(_to, _amount);
        _to.transfer(_amount);
    }

    /// Reverter função renunciar contrato, não dá para remover
    function renounceOwnerShip() public override onlyOwner {
        revert("Can't renounceOwnerShip here"); //not possible with this smart contract
    }

    receive() external payable {
        emit MoneySent(msg.sender, msg.value);
    }
}

// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.3;

contract FunctionsExample {
    // Variavel de Mapping
    mapping(address => uint256) public balanceReceived;

    // Varivavel de Estado
    address payable private owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function getOwner() public view returns (address) {
        return owner;
    }

    function convertWeiToEth(uint256 _amount) public pure returns (uint256) {
        return _amount / 1 ether;
    }

    function destroySmartContract() public {
        require(msg.sender == owner, "You are not the owner");
        // Destruir contrato pode ser descontinuado
        selfdestruct(owner);
    }

    function receiveMoney() public payable {
        assert(
            balanceReceived[msg.sender] + msg.value >=
                balanceReceived[msg.sender]
        );
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint256 _amount) public {
        require(_amount <= balanceReceived[msg.sender], "not enough funds.");
        assert(
            balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount
        );
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
    /// Recebe os valores sem interagir com function
    receive() external payable {
        receiveMoney();
    }
}

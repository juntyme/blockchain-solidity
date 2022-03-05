//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract MappingsStructExample {
    // Os mapeamentos não têm comprimento. É importante entender isso. Os arrays têm um comprimento, mas,
    // como os mapeamentos são armazenados internamente, eles não têm um comprimento.

    // Segundo Nivel
    struct Payment {
        uint256 amount;
        uint256 timestamp;
    }

    // Como os mapeamentos não têm comprimento, não podemos fazer algo como balanceReceived.lengthou payments.length

    /// Primeiro nivel
    struct Balance {
        uint256 totalBalance;
        uint256 numPayments;
        mapping(uint256 => Payment) payments;
    }

    mapping(address => Balance) public balanceReceived;

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        balanceReceived[msg.sender].totalBalance += msg.value;

        Payment memory payment = Payment(msg.value, block.timestamp);
        balanceReceived[msg.sender].payments[
            balanceReceived[msg.sender].numPayments
        ] = payment;
        balanceReceived[msg.sender].numPayments++;
    }

    function withdrawMoney(address payable _to, uint256 _amount) public {
        require(
            _amount <= balanceReceived[msg.sender].totalBalance,
            "not enough funds"
        );
        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }

    function withdrawAllMoney(address payable _to) public {
        uint256 balanceToSend = balanceReceived[msg.sender].totalBalance;
        balanceReceived[msg.sender].totalBalance = 0;
        _to.transfer(balanceToSend);
    }

    // Na verdade, armazenamos as chaves em numPayments, o que significa que o pagamento
    //  atual está em balanceReceived[0x123...].numPayments. Se juntarmos isso,
    //  podemos fazer balanceReceived[0x123...].payments[balanceReceived[0x123...].numPayments].amount = ....
}

// SPDX-License-Identifier: GPL-3.0

/** https://docs.soliditylang.org/en/v0.8.11/080-breaking-changes.html */

/**
Tamanhos da uint
uint8 : 0 a 255
uint16 :
uint32
uint64
uint128
uint256
 */

pragma solidity >=0.5.2 <=0.8.12;

library SafeMath {
    // Função Matematica função pure
    function sum(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;

        require(c >= a, "Sum Overflow"); // impedir Overflow

        return c;
    }

    // Função subtraçãop
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "Sub UnderFlow!");

        uint256 c = a - b;

        return c;
    }

    // Função multiplicação
    function mult(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "Mul Overflow");

        return c;
    }

    // Função divisão
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a / b;

        return c;
    }
}

/** HERANÇA */
contract Ownable {
    // variavel do endereço do dono
    address public owner;

    event OwnershipTransferred(address newOwner);

    // Apenas uma vez no contrato
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner!");
        // Executa o que vier depois
        _;
    }

    // Tranferir a posse do contrato
    function transferOwnership(address payable newOwner) public onlyOwner {
        owner = newOwner;
        emit OwnershipTransferred(owner);
    }
}

contract HelloWorld is Ownable {
    using SafeMath for uint256;

    uint256 public price = 25000000 gwei;
    mapping(address => uint256) public balances;

    //  balances[owner] = balances[owner].sum(msg.value);

    event NewPrice(uint256 newPrice);

    function whatAbout(uint256 myNumber)
        public
        payable
        returns (string memory)
    {
        require(myNumber <= 10, "Number out or range.");
        require(msg.value == price, "insufficient ETH sent.");

        // Duplicar valor de Price
        doublePrice();

        if (myNumber > 5) {
            return "E maior que cinco!";
        }
        return "E menor ou igual a cinco";
    }

    function doublePrice() private pure {
        price = price.mult(2);

        emit NewPrice(price);
    }

    function withdraw(uint256 myAmount) public onlyOwner {
        // Balance é uma propriedade nativa de todo endereço () includive endereços de contratos
        require(address(this).balance >= myAmount, "Insufficient funds.");

        // balances[owner] = balances[owner].sub(myAmount);
        owner.transfer(myAmount);
    }
}

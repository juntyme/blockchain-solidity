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

    // Variavel Public Texto
    string public text;

    // Variavel Inteira uint256
    uint256 public number;

    // Variavel endereço
    address public userAddress;

    // Variavel com parametro addres para uint
    mapping(address => uint256) public hasInteracted;
    mapping(address => uint256) public balances;

    // parametro tipo texto mytext, memory apenas quando for executado
    function setText(string memory myText) public {
        text = myText;
        setInteracted();
    }

    // payable realiza cobrança de ETH
    function setNumber(uint256 myNumber) public payable {
        require(msg.value >= 1 ether, "insufficient ETH sent."); // Condição

        balances[msg.sender] = balances[msg.sender].sum(msg.value);
        number = myNumber;
        setInteracted();
    }

    function setUserAddress() public {
        userAddress = msg.sender;
        setInteracted();
    }

    // Função Privada Chamar mapping
    function setInteracted() private {
        hasInteracted[msg.sender] = hasInteracted[msg.sender].sum(1);
    }

    // Função Transferir ether
    function sendETH(address payable targetAddress) public payable {
        targetAddress.transfer(msg.value);
    }

    // Padão PROBLEMA DA REENTRACIA
    function withdraw() public payable {
        require(balances[msg.sender] > 0, "Insufficient funds.");

        // Variavel de scopo impede que o contrato seja retirado valores superior
        uint256 amount = balances[msg.sender];
        balances[msg.sender] = balances[msg.sender].sum(msg.value);
        payable(msg.sender).transfer(amount); /// Correção
    }

    // Função do tipo wiew só consulta mas não altera
    function sumStored(uint256 num1) public view returns (uint256) {
        // Primeiro parametro é a variavel "num1"
        return num1.sum(number);
    }
}

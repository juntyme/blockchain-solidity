/*
(\n) - Inicia uma nova linha.
(\\) - Barra invertida
(\') - Citação única
(\") - Citação dupla
(\b) - Retrocesso
(\f) - Feed de formulário
(\r) - Devolução de carro
(\t) - Aba
(\v) - Guia Vertical
(\xNN) - Representa o valor hexadecimal e insere os bytes apropriados.
(\uNNNN) - Representa o valor Unicode e insere a sequência UTF-8.

pragma solidity ^0.5.0;

contract SolidityTest {
    string data = "test"; ///Strig literal requer mais gas para execução
    bytes32 data2 = "test"; ////  conversão embutida entre bytes para string e vice-versa bytes1 atpe bytes32

    // Bytes podem ser convertidos em String usando o construtor string().
    bytes memory bstr = new bytes(10);
    string message = string(bstr);
}
*/

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.0;

contract SolidityTest {
    constructor() public {}

    function getResult() public view returns (string memory) {
        uint256 a = 1;
        uint256 b = 2;
        uint256 result = a + b;
        return integerToString(result);
    }

    function integerToString(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;

        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len - 1;

        while (_i != 0) {
            bstr[k--] = bytes1(uint8(48 + (_i % 10)));
            _i /= 10;
        }
        return string(bstr);
    }
}

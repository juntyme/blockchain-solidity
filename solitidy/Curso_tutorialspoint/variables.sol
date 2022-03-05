// Solidity é uma linguagem de TIPAGEM ESTÁTICA, o que
// significa que o tipo de variável de estado ou local
// precisa ser especificado durante a declaração.
// Cada variável declarada sempre tem um valor padrão baseado em seu tipo.
//  Não há conceito de "indefinido" ou "nulo".

// Variáveis de Estado − Variáveis cujos valores são armazenados permanentemente em um armazenamento de contrato.

// Variáveis Locais − Variáveis cujos valores estão presentes até que a função esteja sendo executada.

// Variáveis Globais – Existem variáveis especiais no namespace global usado para obter informações sobre o blockchain.

// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.5.0;

contract SolidityTest {
    uint256 storedData; // Estado variável

    constructor() public {
        storedData = 10; // Usando a variável de estado
    }

    function getResult() public view returns (uint256) {
        uint256 a = 1; // variavel local
        uint256 b = 2;
        uint256 result = a + b;
        return result; // acessa a variável local
    }
}

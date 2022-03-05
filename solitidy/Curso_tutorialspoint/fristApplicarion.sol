// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.5.11;

contract SolidityTest {
    /// Contrutor apenas uma ves no contrato
    constructor() public {}

    // Este é um comentário. É semelhante aos comentários em C++

    /*
       * Este é um comentário de várias linhas em solidez
       * É muito semelhante aos comentários em Programação C
    */

    // bool	true/false
    // int/uint	Inteiros assinados e não assinados de tamanhos variados.
    // int8 to int256	Int assinado de 8 bits a 256 bits. int256 é o mesmo que int.
    // uint8 to uint256	Unsigned int de 8 bits a 256 bits. uint256 é o mesmo que uint.
    // fixed/unfixed	Números de pontos fixos assinados e não assinados de tamanhos variados.
    // fixedMxN	    Número de ponto fixo assinado onde M representa o número de bits tomados pelo tipo e N representa os pontos decimais.
    //              M deve ser divisível por 8 e vai de 8 a 256. N pode ser de 0 a 80. fixed é igual a fixed128x18.
    // ufixedMxN	Número de ponto fixo sem sinal onde M representa o número de bits tomados pelo tipo e N representa os pontos decimais.
    //              M deve ser divisível por 8 e vai de 8 a 256. N pode ser de 0 a 80. ufixed é o mesmo que ufixed128x18.

   // Função pura não chama nenhuma outra função grátis
    function getResult() public pure returns (uint256) {
        uint256 a = 1;
        uint256 b = 2;
        uint256 result = a + b;
        return result;
    }
}

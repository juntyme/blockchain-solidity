// Público − As variáveis de estado públicas podem ser acessadas internamente,
//         bem como por meio de mensagens. Para uma variável de estado pública,
//         uma função getter automática é gerada.

// Interno − As variáveis de estado internas podem ser acessadas apenas internamente
//          a partir do contrato atual ou do contrato derivado dele sem usar isso.

// Privado − As variáveis de estado privado podem ser acessadas apenas internamente
//         a partir do contrato atual, elas são definidas e não no contrato derivado dele.

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.0;

contract C {
    uint256 public data = 30;
    uint256 internal iData = 10;

    function x() public returns (uint256) {
        data = 3; // internal access variavel interna
        return data;
    }
}

contract Caller {
    C c = new C(); /// chama o contrato

    function f() public view returns (uint256) {
        return c.data(); // external access
    }
}

contract D is C {
    function y() public returns (uint256) {
        iData = 3; // internal access
        return iData;
    }

    function getResult() public view returns (uint256) {
        uint256 a = 1; // local variable
        uint256 b = 2;
        uint256 result = a + b;
        return result; // access the state variable
    }
}

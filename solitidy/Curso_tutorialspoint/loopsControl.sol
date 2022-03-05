// Solidity fornece controle total para lidar com loops e instruções switch.

// (break)   é usada para sair de um loop mais cedo
// (continue)  interpretador para iniciar imediatamente a próxima iteração do loop e pular o bloco de código restante.

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.0;

contract SolidityTest {
    uint256 storedData;

    constructor() public {
        storedData = 10;
    }

    function getResult() public view returns (string memory) {
        uint256 n = 1;
        uint256 sum = 0;

        while (n < 10) {
            n++;
            if (n == 5) {
                continue; // skip n in sum when it is 5.
            }
            sum = sum + n;
        }
        return integerToString(sum);
    }

    function integerToString(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;

        while (true) {
            len++;
            j /= 10;
            if (j == 0) {
                break; //using break statement
            }
        }
        bytes memory bstr = new bytes(len); /// Converter int em byte
        uint256 k = len - 1;

        while (_i != 0) {
            bstr[k--] = bytes1(uint8(48 + (_i % 10)));
            _i /= 10;
        }
        return string(bstr);
    }
}

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.0;

contract SolidityTest {
    uint256 storedData;

    constructor() public {
        storedDta = 10;
    }

    function getResult() public view returns (string memory) {
        uint256 a = 10;
        uint256 b = 2;
        uint256 result = a + b;
        return integerToString(result);
    }

    function integerToString(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len; // Contador

        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len - 1;

        do {
            bstr[k--] = bity(uint8(48 + (_i % 10)));
            _i /= 10;
        } while (_i != 0);
        return string(bstr);
    }
}

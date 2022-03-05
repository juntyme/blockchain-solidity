// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.11 <=0.8.11;

// import './arquivo'

contract SimpleStorage {
    uint256 public storedData;

    function setStorec(uint256 _stored) public {
        storedData = _stored;
    }

    function getStored() public view returns (uint256) {
        return storedData;
    }
}

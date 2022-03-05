// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.4;

contract WillThrow {
    function aFunction() public pure {
        require(false, "Error message");
    }
}

contract ErrorHandling {
    /// Mostrar evento
    event ErrorLogging(string reason);

    function catchError() public {
        WillThrow will = new WillThrow();
        try will.aFunction() {
            //aqui podemos fazer algo se funcionar
        } catch Error(string memory reason) {
            // Chamar evento
            emit ErrorLogging(reason);
        }
    }
}

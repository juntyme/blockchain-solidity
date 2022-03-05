//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract SimpleMappingExample {
    // O mapeamento é um tipo de dados interessante no Solidity. Eles são acessados ​​como arrays,
    // mas têm uma grande vantagem: todos os pares chave/valor são inicializados com seu valor padrão.

    // Podemos acessar um mapeamento com os colchetes [].
    // Se quisermos acessar a chave "123" em nosso myMapping, simplesmente escrevemos myMapping[123].
    mapping(uint256 => bool) public myMapping;
    mapping(address => bool) public myAddressMapping;

    function setValue(uint256 _index) public {
        myMapping[_index] = true;
    }

    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }
}

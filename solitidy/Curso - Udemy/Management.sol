//SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract ItemManager{

    enum SupllyChainSteps{Created, Paid, Delivered}

    struct S_Item {
        ItemManager.SupllyChainSteps _step;
        string _identifier;
        uint _priceInWei;
    }

    mapping(uint => S_Item) public items;
    uint index;

    event SupplyChainStep(uint _itemIndex, uint _step);

    function createItem(string memory _identifier, uint _priceInWei) public {

        items[index]._priceInWei = _priceInWei;
        items[index]._step = SupplyChainSteps.Created;
        items[index]._identifier = _identifier;

        emit SupllyChainSteps(index, uint(items[index]._step));
        index++;
    }

    function triggerPayment(uint _index) public payable {
        require(items[_index]._priceInWei <= msg.value, "Not fully paid");
        require(items[_index]._step == SupplyChyainSteps.Created, "Item is further in the supply chain");
        items[_index]._step = SupplyChainSteps.Delivered;
        emit SupllyChainSteps(_index, uint(items[_index].step));
    }
    
     function triggerDelivery(uint _index) public {
        require(items[_index]._step == SupplyChainSteps.Paid, "Item is further in the supply chain");
        items[_index]._step = SupplyChainSteps.Delivered;
        emit SupplyChainStep(_index, uint(items[_index]._step));
    }

}
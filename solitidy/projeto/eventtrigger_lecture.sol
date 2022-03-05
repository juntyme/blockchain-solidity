pragma solidity ^0.6.0;

contract Ownable {

    address payable _owner;

    constructor() public {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(isOwner(), "You are not the owner");
        _;
    }

    function isOwner() public view returns(bool) {
        return (msg.sender == _owner);
    }
}

contract Item {
    uint public priceInWei;
    uint public pricePaid;
    uint public index;

    ItemManager parentContract;

    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) public {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }

    // Função Fallback
    receive() external payable {
        require(pricePaid == 0, "Item is paid already");
        require(priceInWei == msg.value, "Only full payments allowed");
        pricePaid += msg.value;
        /// Funçãod e baixo nivel informar que tipo de indice
       (bool success, ) = address(parentContract).call.value(abi.encodeWithSignature("triggerPayment(uint256)", index));
       require(success, "The transaction wasn't successful, canceling");
    }

    fallback() external {

    }
}


contract ItemManager is Ownable {

    // Lista de Opções
    enum SupplyChainState{Created, Paid, Delivered};

    struct S_Item {
        Item _item;
        string _identifier,
        uint _itemPrice,
        ItemManager.SupplyChainState _state;

    }

    // Armazenas os items
    mapping (uint => S_Item) public items;
    uint itemIndex; // inicio 0

    event SupplyChainStep(uint _itemIndex, uint _step, address _itemAddress);

    // Criação do Item
    function createItem(string memory _identifier, uint _itemPrice) public onlyOwner() {
        Item item = new Item(this, _itemPrice, itemIndex); /// Criar Item
        items[itemIndex]._item = item;
        items[itemIndex]._identifier = _identifier;
        items[itemIndex]._itemPrice = _itemPrice;
        items[itemIndex]._state = SupplyChainState.Created;

        // Notificação
        emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state), address(item));
        itemIndex++;
    }

    // Pagamento do Item
    function triggerPayment(uint _itemIndex) public payable {
        require(items[_itemIndex].itemPrice == msg.value, "Only full payments accepted");
        require(items[_itemIndex])._state == SupplyChaubState.Created, "Item is further in the chain");
        items[_itemIndex]._state = SupplyChainState.Paid;

        // Notificação
        emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state), address(item));

    }

    // Entrega do Item
    function triggerDelivery(uint _itemIndex) public onlyOwner() {
         require(items[_itemIndex])._state == SupplyChaubState.Paid, "Item is further in the chain");
        items[_itemIndex]._state = SupplyChainState.Delivered;

         // Notificação
         emit SupplyChainStep(itemIndex, uint(items[itemIndex]._state), address(item));
    }

}
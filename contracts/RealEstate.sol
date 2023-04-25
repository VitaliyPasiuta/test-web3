pragma solidity ^0.8.0;
// @custom:oz-upgrades-unsafe-allow _ProxyAdmin
// @custom:oz-upgrades-unsafe-allow _Proxy
// @custom:dev-run-script {../tests/real_estate.test.js}
contract RealEstate {
  struct Property {
    address owner;
    uint price;
    bool forSale;
  }

  mapping(uint => Property) public properties;
  uint public propertyCount = 0;

  function addProperty(uint _price) public {
    properties[propertyCount] = Property(msg.sender, _price, true);
    propertyCount++;
  }

  // function buyProperty(uint _id) payable public {
  //   Property storage property = properties[_id];
  //   require(property.forSale == true, "Property is not for sale.");
  //   require(msg.value >= property.price, "Insufficient payment.");

  //   address payable seller = payable(property.owner);
  //   seller.transfer(msg.value);
  //   property.owner = msg.sender;
  //   property.forSale = false;
  // }

  function buyProperty(uint _id) payable public {
    Property storage property = properties[_id];
    require(property.forSale == true, "Property is not for sale.");

    uint price = property.price;
    require(address(this).balance >= price, "Insufficient balance in contract.");

    if (msg.value < price) {
        uint refund = price - msg.value;
        payable(msg.sender).transfer(refund);
    }

    address payable seller = payable(property.owner);
    seller.transfer(price);
    property.owner = msg.sender;
    property.forSale = false;
}

  function logProperties() public {
  for (uint i = 0; i < propertyCount; i++) {
    Property storage property = properties[i];
    emit LogProperty(i, property.owner, property.price, property.forSale);
  }
}

event LogProperty(uint indexed id, address owner, uint price, bool forSale);

}



// pragma solidity ^0.8.0;

// contract RealEstate {
//     enum State { ForSale, Sold }
//     State public state;
//     address payable public seller;
//     uint public price;
//     uint public realEstateId;
    
//     struct RealEstateData {
//         address payable buyer;
//         string location;
//         string description;
//     }
    
//     mapping(uint => RealEstateData) public realEstates;

//     constructor(uint _price) {
//         seller = payable(msg.sender);
//         price = _price;
//         state = State.ForSale;
//     }
    
//     function addRealEstate(uint _realEstateId, string memory _location, string memory _description) public {
//         realEstates[_realEstateId] = RealEstateData(payable(address(0)), _location, _description);
//     }

//     function buy(uint _realEstateId) public payable {
//         RealEstateData storage realEstate = realEstates[_realEstateId];
//         require(state == State.ForSale, "Already sold");
//         require(msg.value == price, "Incorrect price");
//         require(realEstate.buyer == address(0), "Already sold");
//         realEstate.buyer = payable(msg.sender);
//         state = State.Sold;
//         seller.transfer(msg.value);
//     }

//     function cancel(uint _realEstateId) public {
//         require(msg.sender == seller, "Unauthorized");
//         RealEstateData storage realEstate = realEstates[_realEstateId];
//         require(state == State.ForSale, "Already sold");
//         require(realEstate.buyer == address(0), "Already sold");
//         state = State.Sold;
//         seller.transfer(address(this).balance);
//     }
// }

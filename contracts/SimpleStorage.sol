// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract  SimpleStorage {

    // Basic types: boolean --> True/False
    // uint --> unsigned integer aka positive whole number
    // int --> signed integer both positive/negative whole numbers
    // address --> similar to address
    //bytes --> lowest code .

    uint256 myfavoriteNumber; // --> 0

    //uint256[] listOfFavoriteNumbers;
    struct Person{
        uint256 favoriteNumber;
        string name;
    }

    //dynamic array
    Person[] public  listOfPeople;

    mapping(string => uint256) public nameToFaovoriteNumber;


    // Person public myFriend = Person({favoriteNumber:7, name:"Pat"});
    // Person public Trump = Person({favoriteNumber:1, name:"Trump"});
    // Person public Friend = Person({favoriteNumber:3, name:"Mariah"});

    function store(uint256 _favoriteNumber) public {
        myfavoriteNumber = _favoriteNumber;
    }

    function multiply(uint256 _newNumber) public {
        myfavoriteNumber = myfavoriteNumber * _newNumber;
    }

    function retrieve()public  view returns(uint256) {
        return myfavoriteNumber;
    }
   //0xd9145CCE52D386f254917e481eB44e9943F39138

   // [calldata, memory] --> exist temporarily , storage
   // 
   function addPerson(string memory name, uint256 _favoriteNumber)public{
    listOfPeople.push(Person(_favoriteNumber,name));
    nameToFaovoriteNumber[name] = _favoriteNumber;
   }

}
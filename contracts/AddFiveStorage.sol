
// SPDX-License-Identifier: MIT

pragma solidity  0.8.24;

import {SimpleStorage} from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage{
    
    // add to each favoriteNumber +5
    // overides --> Virtual override

    function store(uint256 _newNumber)public override {
        myfavoriteNumber = _newNumber * 5; 
    }

    function multiply(uint256 _newNumber) public override {
        myfavoriteNumber = _newNumber * myfavoriteNumber;
    }
}

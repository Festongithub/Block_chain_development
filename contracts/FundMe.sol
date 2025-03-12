// SPDX-License-Identifier: MIT

pragma solidity 0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address[] public funders;
    mapping (address funder =>uint256 amountFunded) public addressToAmountFunded;

    address public  immutable i_Owner;

    constructor(){
        i_Owner = msg.sender;
    }

    function fund()public payable {
        require(msg.value.getConversionRate() > MINIMUM_USD,"The minimum amount of value is not met");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public {

        for(uint256 funderIndex = 0 ; funderIndex < funders.length; funderIndex++)
        {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        // transfer
        payable(msg.sender).transfer(address(this).balance);

        // send
        bool sendSucess = payable(msg.sender).send(address(this).balance);
        require(sendSucess, "Send failed");

        // call
        (bool callSucess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucess,"Call failed");
    }

    modifier  onlyOwner(){
        // require(msg.sender == i_Owner, "Only the owner can call this function.");
        if(msg.sender != i_Owner)
        {
            revert NotOwner();
        }
        _;
    }

    receive() external payable { 
        fund();
    }

    fallback() external payable {
        fund();
     }
}
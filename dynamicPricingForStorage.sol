//Question 10: Create a smart contract that implements a dynamic pricing model for a decentralized storage system.
// To create a smart contract where storage system can be accessed by paying certain ETH, we should mainly have owner, user, cost of storage and amount of storage user needs.
// first we should declare all the required variables and two functions are created. 
// one function is to purchase storage system and other one is to withdraw funds which is only accessed by the owner.
// cost of storage per GB is declared by the owner at the beginning, based on that price and amount of storage system required by the user, payment is made.






// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;

contract dynamicPricing {
    address payable public owner;
    uint256 public storagePrice;
    uint256 public storageAmount;
    mapping(address => uint256) public userStorage;

    event StoragePurchased(address indexed purchaser, uint256 storageAmount);
    event FundsWithdrawn(address indexed recipient, uint256 amount);

    constructor(uint256 _storagePriceForOneGB) {
        owner = payable(msg.sender);
        storagePrice = _storagePriceForOneGB;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You have no access");
        _;
    }

    function purchaseStorage(uint256 storageAccessInGB) external payable {
        uint256 totalStoragePrice = storagePrice * storageAmount;
        require(msg.value >= totalStoragePrice, "Insufficient funds");
        userStorage[msg.sender] += storageAccessInGB;
        
        emit StoragePurchased(msg.sender, storageAccessInGB);
    }

    function withdrawFunds(uint256 amount) external onlyOwner {
        require(address(this).balance >= amount, "Insufficient contract balance");
        owner.transfer(amount);
        
        emit FundsWithdrawn(owner, amount);
    }
}

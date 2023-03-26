// Solidity function to implement a rentable storage system, where users can rent storage space in exchange for tokens.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface USDC {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract CloudStorageRent {
    USDC public usdcToken;
    address public owner;
    uint256 public rentPrice;
    uint256 public rentPeriod;
    mapping(address => uint256) public rentedStorage;

    constructor(address _usdcToken, uint256 _rentPrice, uint256 _rentPeriod) {
        usdcToken = USDC(_usdcToken);
        owner = msg.sender;
        rentPrice = _rentPrice;
        rentPeriod = _rentPeriod;
    }

    function rentStorage() external payable {
        require(msg.value == 0, "Do not send ETH to this contract.");
        require(rentedStorage[msg.sender] == 0, "You have already rented a storage.");
        require(usdcToken.transferFrom(msg.sender, owner, rentPrice), "Transfer failed.");

        rentedStorage[msg.sender] = block.timestamp + rentPeriod;
    }

    function isStorageRented(address _user) public view returns(bool) {
        return rentedStorage[_user] >= block.timestamp;
    }

    function extendStorageRent() external payable {
        require(msg.value == 0, "Do not send ETH to this contract.");
        require(isStorageRented(msg.sender), "You have not rented a storage.");
        require(usdcToken.transferFrom(msg.sender, owner, rentPrice), "Transfer failed.");

        rentedStorage[msg.sender] += rentPeriod;
    }

    function withdrawRentalFunds() external {
        require(msg.sender == owner, "Only the contract owner can withdraw rental funds.");
        require(address(usdcToken).transfer(owner, usdcToken.balanceOf(address(this))), "Withdrawal failed.");
    }
}

// Question 7: Write a Solidity function to check the balance of a given address.


pragma solidity ^0.8.2;

contract checkBalnce{
    address public owner;
    uint amount;

    mapping(address => uint) public balances;

    function getBalance() public view returns(uint){
      return address(this).balance;
    }
}

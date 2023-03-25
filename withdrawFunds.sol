// Question 3: Smart contract to withdraw funds.

// Here we will write a simple smart contract which will lead to withdrawing funds.
//  There are two functions, one is to deposit funds to contract and other one is to withdraw funds and send it to owners address.




pragma solidity 0.8.12;

contract withdrawFunds {

    
     address payable public owner;
     uint public balance;
     uint public withdrawalLimit;
     uint public withdrawalTime;
     mapping(address => uint) public withdrawals;

    constructor(uint limit){
        owner = payable(msg.sender);
        withdrawalLimit = limit;
        withdrawalTime = block.timestamp;
 }

 function deposit() public payable {
  balance += msg.value;

 }

function withdraw(uint amount) public payable{
    require(amount <= balance, "amount insuffiecent");
    require(msg.sender == owner, "Only the owner can withdraw funds.");
        require(amount <= withdrawalLimit, "Withdrawal amount exceeds the limit.");
        require(block.timestamp <= withdrawalTime, "time exceeded");
        require(withdrawals[msg.sender] + amount <= withdrawalLimit, "Withdrawal amount exceeds your limit.");
    owner.transfer(amount);

     balance -= amount;

     withdrawals[msg.sender] += amount;
     withdrawalTime = block.timestamp;
    }
    
    function getBalance(uint amount) public view returns(uint) {
        return address(this).balance;
    }
    
    


}

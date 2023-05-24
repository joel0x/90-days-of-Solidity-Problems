//Question 9: write a smart contract which let the users to make payments to the owner.
// solution : Here I have used variable owner which accept payments and withdraw funds to owner account. Also constructor has been used to make sure only owner has the //access. modifier onlyOwner is written to make withdraw Funds accessible only to owner. payMoney function is called to make payments to the owner. Owner balance will be 
//updated only when withdrawFunds is called. 



pragma solidity^0.8.0;
contract payment {

    address payable public owner;
    uint public paymentAmount = 1 ether;
 

     mapping(address=> bool) public payments;
   

     event PaymentReceived(address indexed sender, uint256 amount);

    constructor(){
       owner =  payable(msg.sender);
    
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "you have no access");
        _;

    }

    function payMoney() external payable{
        require(msg.value>= paymentAmount,"insuffiecient money ");
        payments[msg.sender]=true;
        // payments[msg.value]=true;
        emit PaymentReceived(msg.sender, msg.value);
}

    function withdrawFunds(uint256 amount) external payable onlyOwner {
        require(msg.sender == owner, "only owner can access");
         uint256 contractBalance = address(this).balance;
          require(amount <= contractBalance, "Insufficient contract balance");
        owner.transfer(amount);
    }


}


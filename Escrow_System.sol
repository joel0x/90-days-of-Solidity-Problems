Question 2: Write a Solidity function to implement a trustless escrow system, where funds are held in escrow until certain conditions are met.

// Before we dive into code, let us know what is escrow. In simple words, escrow is a third party that manages money between any two clients. This collects all the funds and locks them until all the required agreements and document process is complete. Once it is done, the funds are released to the desired client. This helps to achieve a trustless contract to complete any sort of business.

// Real estates and business transactions are the popular use cases of escrow. 

// So, now we know what escrow is, let us understand how to write a smart contract that locks and releases the funds. Since we know there are 3 people in the whole process. so we have 3 main variables that is buyer, seller, and mediator, also the last one is the amount. 
// Now there are certain conditions that need to be considered, so we use modifiers to accomplish those. the conditions are only the buyer should send the money, similarly only the seller and only the mediator should be part, and no other address must be involved.
// Once the modifiers are designed, we use functions to lock, release, refund, and resolve the money.

'''solidity code

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract escrow {

    address payable public buyer;
    address payable public seller;
    address payable public mediator;
    uint amount;

    enum situation {Active, Locked, Released,  Inactive} 
        situation public state;
    
    constructor(address payable _buyer, address payable _seller, address payable _mediator, uint _amount ){

        buyer = _buyer;
        seller = _seller;
        mediator = _mediator;
        amount = _amount;
        //  state = situation.Active;
}

modifier currentSituation(situation _state){
    require(state == _state, "inavlid state");
    _;
}

modifier onlyBuyer{
    require(msg.sender == buyer, "money is not send buy the buyer");
    _;
}

modifier onlySeller{
    require(msg.sender == seller, "money is not sent to the seller");
    _;
}

modifier onlyMediator{
    require(msg.sender == mediator, "money is not in the hands of mediator");
    _;
}

function lock() payable public currentSituation(situation.Active) onlyBuyer {
    require(msg.value == amount, "amount is not met as per escrow");
    state = situation.Locked;
  
}

function release() public currentSituation(situation.Locked) onlySeller{
    seller.transfer(amount); //important step
    state = situation.Released;
}

function refund() public currentSituation(situation.Locked) onlyMediator{
    buyer.transfer(amount);
    state = situation.Inactive ; 
}

 function resolve() public currentSituation(situation.Locked) onlyMediator{
        seller.transfer(amount / 2);
        buyer.transfer(amount / 2);
        state = situation.Inactive;
    }

function getSituation() public view returns(uint){
    return amount;
}

function getBalance() public view returns(uint){
    return address(this).balance; //imp step
}

}

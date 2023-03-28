// Question 5: Write a Solidity function to implement a staking system, where users can earn rewards for holding tokens.

// here we first import the ERC20 token and write a contract mentioning the initial amount of supply. we write 3 functions mentioning to stake, unstake, and claim the tokens. 
// In function stake it's written showing the amount must be greater than zero also user balance of the user must be greater than or equal to zero.
// Before we stake any tokens, we should check whether is there any tokens that need to be claimed, if there are any tokens then we claim them. or else we stake tokens using block.timestamp
// similarly we write function unstake containing same required statements and claim tokens.
// Now in the function claim, it is mentioned how to earn rewards based on the number of seconds and we mint the rewards



//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

    contract stakeRewards is ERC20{
        mapping(address => uint256) public staked;
        mapping(address => uint256) public stakedFromtimeStamp;
    constructor(uint256) ERC20 ("Fixed Stake", "FIX" ) {
        _mint(msg.sender, 100000000);
    }

    function stake(uint256 amount) external{
        require(amount>0, "amount<0");
        require(balanceOf(msg.sender)>=amount, "insuffient balance");
        _transfer(msg.sender, address(this), amount);
        if(staked[msg.sender] > 0){
            claim();
        }

        stakedFromtimeStamp[msg.sender] = block.timestamp;
        staked[msg.sender] += amount;
    }

    function unstake(uint256 amount) external{
        require(amount > 0, "");
        require(balanceOf(msg.sender)>=amount, "");
        claim();
        staked[msg.sender] -= amount;
        _transfer(address(this), msg.sender, amount);

    }

    function claim() public{
        require(staked[msg.sender]>=0, "");
        uint256 secondsStaked = block.timestamp -  stakedFromtimeStamp[msg.sender];
        uint256 rewards = staked[msg.sender] * secondsStaked / 3.154e7;
        _mint(msg.sender, rewards);
        stakedFromtimeStamp[msg.sender] = block.timestamp;
    }

    
}


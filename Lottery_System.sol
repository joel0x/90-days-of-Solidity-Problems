// Question 8: Write a Solidity function to implement a lottery, where users can buy tickets for a chance to win a prize.
// solution :
// We have a manager who is organizing a lottery with multiple members participating. 
// At the end of the lottery, there will be one winner. Initially, the manager sets the ticket price and creates a constructor function. 
// Members can buy a ticket by sending the required amount of Ether. 
// To ensure fairness, the winner is randomly selected based on the current timestamp and a time delay is introduced to prevent manipulation.
// Finally, the selected winner is declared based on the result of the randomness.


pragma solidity ^0.8.1;

contract Lottery {
    address public manager;
    address[] public members;
    address payable public winner;
    uint public balance;

    uint constant TICKET_PRICE = 10000000000000000; // 0.01 ether in wei

    constructor() payable {
        manager = msg.sender;
    }

    function buyTicket() public payable {
        require(msg.value == TICKET_PRICE);
        members.push(msg.sender);
        balance += msg.value;
    }

    function random() private view returns (uint) {
        uint delay = block.timestamp % 60; // Get seconds in the current minute
        uint entropy = uint(keccak256(abi.encodePacked(block.timestamp, members.length)));
        uint random_number = uint(keccak256(abi.encodePacked(block.timestamp, entropy, delay)));
        return random_number % members.length;
    }

    function selectWinner() public restricted {
        uint index = random();
        winner = payable(members[index]);
        balance = 0;
        winner.transfer(address(this).balance);
    }

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
}

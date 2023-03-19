// Solidity function to implement a voting system, where each address can vote only once.





pragma solidity ^0.7.0;

// Define the contract
contract votingSystem {
    
    // Define a struct to represent a candidate
    struct Candidate {
        string name;
        uint256 voteCount;
    }
    
    // Define an array to store the list of candidates
    Candidate[] public candidates;
    
    // Define a mapping to know whether an address has voted
    mapping(address => bool) private hasVoted;
    
    // Define a constructor to add initial candidates to the list
    constructor() {
        addCandidate("jack");
        addCandidate("joy");
        addCandidate("karem");
    }
    
    // Define a function to add a candidate to the list
    function addCandidate(string memory name) private {
        candidates.push(Candidate(name, 0));
    }
    
    // Define a function to allow a user to vote for a candidate
    function vote(uint256 candidateIndex) public {
        // Check if the user has already voted
        require(!hasVoted[msg.sender], "Address has already voted");
        
        // Check that the candidate index is valid
        require(candidateIndex < candidates.length, "Invalid candidate index");
        
        // Record that the user has voted
        hasVoted[msg.sender] = true;
        
        // Increment the vote count for the selected candidate
        candidates[candidateIndex].voteCount++;
    }
    
    // Define a function to get the winner of the election
    function getWinner() public view returns (string memory) {
        // Initialize variables to keep track of the winning candidate
        uint256 maxVotes = 0;
        uint256 winningCandidateIndex = 0;
        
        // Loop through all candidates and find the one with the most votes
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winningCandidateIndex = i;
            }
        }
        
        // Return the name of the winning candidate
        return candidates[winningCandidateIndex].name;
    }
    
}


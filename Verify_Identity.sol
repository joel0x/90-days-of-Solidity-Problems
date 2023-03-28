// Question 6: Verify the identity of the user using their address rather than depending on the centralized system.

// here two functions are used to verify the user address. To have a proper decentralized identity system, we must first make sure the user has deployed all his credentials
// All the data must be stored in IPFS and private and public addresses must be generated, later on we can use this to verify users' identity.


pragma solidity ^0.8.0;

contract identityVerification {
    mapping(address => bool) public verifiedAddress;

    function identityVerify() public {
        verifiedAddress[msg.sender] = true;
    }

    function isAddressVerified(address userAddress) public view returns (bool) {
        return verifiedAddress[userAddress];
    }
}

pragma solidity ^0.8.0;

//This contract is vulnerable to front-running attacks, as an attacker can monitor the mempool for new bids and submit their own bid with a slightly 
// higher value and a higher gas price. This increases the likelihood that their transaction will be processed before the original one, effectively 
// outbidding the original bidder.

contract VulnerableAuction {
    address public highestBidder;
    uint256 public highestBid;
    uint256 public auctionEndTime;

    constructor(uint256 _duration) {
        auctionEndTime = block.timestamp + _duration;
    }

    function bid() external payable {
        require(block.timestamp < auctionEndTime, "Auction has ended");
        require(msg.value > highestBid, "Bid is not higher than the current highest bid");

        if (highestBidder != address(0)) {
            // Refund the previous highest bidder
            payable(highestBidder).transfer(highestBid);
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    function endAuction() external {
        require(block.timestamp >= auctionEndTime, "Auction has not ended yet");
        selfdestruct(payable(highestBidder));
    }
}


// In this modified contract, users first commit their bids using the commitBid() function, which stores a commitment (a hash of the bid value and a secret)
// in the contract. After the auction ends, there's a reveal phase where users reveal their actual bids using the revealBid() function.
contract CommitRevealAuction {
    address public highestBidder;
    uint256 public highestBid;
    uint256 public auctionEndTime;
    uint256 public revealEndTime;

    mapping(address => bytes32) public commitments;

    constructor(uint256 _auctionDuration, uint256 _revealDuration) {
        auctionEndTime = block.timestamp + _auctionDuration;
        revealEndTime = auctionEndTime + _revealDuration;
    }

    // @dev allows user to commit the desired action
    // @notice the user compute commitment off-chain
    // @notice commitment is a 256-bit hash value computed from {uint bidValue, string secret}
    function commitBid(bytes32 commitment) external {
        require(block.timestamp < auctionEndTime, "Auction has ended");
        commitments[msg.sender] = commitment;
    }

    // @dev revealing sessions
    function revealBid(uint256 value, bytes32 secret) external {
        require(block.timestamp >= auctionEndTime && block.timestamp < revealEndTime, "Reveal phase is not active");
        require(keccak256(abi.encodePacked(value, secret)) == commitments[msg.sender], "Invalid bid reveal");

        if (value > highestBid) {
            if (highestBidder != address(0)) {
                // Refund the previous highest bidder
                payable(highestBidder).transfer(highestBid);
            }

            highestBidder = msg.sender;
            highestBid = value;
        }
    }

    function endAuction() external {
        require(block.timestamp >= revealEndTime, "Auction has not ended yet");
        selfdestruct(payable(highestBidder));
    }
}
